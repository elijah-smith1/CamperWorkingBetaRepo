//
//  usernameSearch.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/14/23.
//

//import SwiftUI
//import FirebaseFirestore
//import Firebase
//
//struct usernameSearch: View {
//    @Published var users = [User]()
//    @State private var searchText = ""
//    @State private var usernames: [String] = []
//
//    var body: some View {
//        VStack {
//            TextField("Search for usernames", text: $searchText)
//                .searchable(text: $searchText) {
//                    ForEach(usernames, id: \.self) { username in
//                        UserCell(username: username)
//                    }
//                }
//                .onChange(of: searchText) { newValue in
//                    // Fetch usernames that contain the search text
//                    let db = Firestore.firestore()
//                    let usernameRef = db.collection("Usernames")
//
//                    usernameRef
//                        .whereField("name", isGreaterThanOrEqualTo: searchText)
//                        .whereField("name", isLessThan: searchText + "z")
//                        .getDocuments { snapshot, error in
//                            if let error = error {
//                                print("Error fetching usernames: \(error)")
//                                return
//                            }
//
//                            guard let snapshot = snapshot else { return }
//
//                            // Update the usernames array with the fetched usernames
//                            usernames = snapshot.documents.map { document in
//                                return document.data()["name"] as? String ?? ""
//                            }
//                        }
//                }
//        }
//    }
//}
//
//
//
//struct usernameSearch_Previews: PreviewProvider {
//    static var previews: some View {
//        usernameSearch()
//    }
//}
