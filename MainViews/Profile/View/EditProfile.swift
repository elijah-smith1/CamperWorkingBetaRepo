//
//  editProfileView.swift
//  letsgetrich
//
//  Created by Michael Washington on 9/16/23.
//

import SwiftUI


struct editProfileView: View {
    @State private var bio = ""
    @State private var isPrivateProfile = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea([.bottom, .horizontal])
                
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .fontWeight(.semibold)
                            
                            Text("AUC LOVEBIRDS")
                        }
                        
                        Spacer()
                        
                 
                    }
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Bio")
                            .fontWeight(.semibold)
                             
                        TextField("Enter your bio...", text: $bio, axis: .vertical)
                    }
                    
                    Divider()
                    
                    Toggle("Private Profile", isOn: $isPrivateProfile)
                }
                .font(.footnote)
                .padding()
                .background(.white)
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                }
                .padding()
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
}

struct editProfileView_Previews: PreviewProvider {
    static var previews: some View {
        editProfileView()
    }
}
