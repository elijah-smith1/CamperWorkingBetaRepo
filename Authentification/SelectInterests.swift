//
//  Select Interests.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/9/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
struct Interests: View {
    var uid: String
    @StateObject var userData = UserData()
    @State private var selectedInterests: Set<String> = []
    @State private var navigate = false // This controls the navigation
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Your other UI elements...
                    
                    ForEach(userData.interests, id: \.self) { interest in
                        Toggle(isOn: Binding(
                            get: { selectedInterests.contains(interest) },
                            set: { isSelected in
                                if isSelected {
                                    selectedInterests.insert(interest)
                                } else {
                                    selectedInterests.remove(interest)
                                }
                            }
                        )) {
                            Text(interest)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Select Interests")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: tabBar(), isActive: $navigate) {
                        Button(action: {
                            // Save the selected interests to Firestore
                            let documentRef = Userdb.document(uid)
                            documentRef.updateData([
                                "interests": Array(selectedInterests)
                            ]) { err in
                                if let err = err {
                                    print("Error updating document: \(err)")
                                } else {
                                    print("Document successfully updated")
                                    self.navigate = true // Set the state variable to true to trigger navigation
                                }
                            }
                        }) {
                            Text("Save")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        }
    }
}





struct Interests_Previews: PreviewProvider {
    static var previews: some View {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            return Interests(uid: uid)
                
        }
        
        // Fallback preview for a non-logged-in user
        return Interests(uid: "ZFFYfUMeAwOs3htOW4bANa05RN02")
            
    }
}
