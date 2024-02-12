//
//  NewMessageViewModel.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/31/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class NewMessageViewModel: ObservableObject {

    @Published var users = [User]()
    
    init(){
        fetchUsers()
    }
    func fetchUsers(){
        
 
        Userdb.getDocuments {snapshot, _ in
            guard let documents = snapshot?.documents else {return}
            print(documents)
            self.users = documents.compactMap({ try? $0.data(as: User.self)})
            print("Debug:: \(self.users)")
      
        }
    }
  

    func createOrRetrieveChatDocument(for selectedUserId: String) async throws -> String {
           let db = Firestore.firestore()

           // Check if a chat already exists in the logged-in user's 'chats' subcollection
           let chatRef = db.collection("Users").document(loggedInUid!).collection("chats").document(selectedUserId)
           let document = try await chatRef.getDocument()
           if document.exists, let chatId = document.data()?["chatId"] as? String {
               // Chat already exists, return the existing chatId
               return chatId
           }

           // No existing chat found in the subcollection, create a new one
           var newChatRef: DocumentReference?
           let chatData: [String: Any] = ["participants": [loggedInUid, selectedUserId]]
           newChatRef = try await db.collection("Chats").addDocument(data: chatData)

           guard let newChatId = newChatRef?.documentID else {
               throw NSError(domain: "FirestoreError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create chat document"])
           }

           // Add chat reference in each user's 'chats' subcollection
           let loggedInUserChatData = ["chatId": newChatId]
           let selectedUserChatData = ["chatId": newChatId]

           try await db.collection("Users").document(loggedInUid!).collection("chats").document(selectedUserId).setData(loggedInUserChatData)
           try await db.collection("Users").document(selectedUserId).collection("chats").document(loggedInUid!).setData(selectedUserChatData)

           return newChatId
       }

    func createGroupChat(for selectedUserIds: [String]) async throws -> String {
           let db = Firestore.firestore()

           // Check if a group chat already exists with the selected users
          
           // No existing group chat found, create a new one
           var newChatRef: DocumentReference?
           let chatData: [String: Any] = ["participants": selectedUserIds]
           newChatRef = try await db.collection("Chats").addDocument(data: chatData)

           guard let newChatId = newChatRef?.documentID else {
               throw NSError(domain: "FirestoreError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create group chat document"])
           }

           // Add chat reference in each user's 'chats' subcollection
           for selectedUserId in selectedUserIds {
               let selectedUserChatData = ["chatId": newChatId]
               try await db.collection("Users").document(selectedUserId).collection("chats").document(newChatId).setData(selectedUserChatData)
           }

           return newChatId
       }
    
    
    
    
    

         // Replace with actual logged in user ID
        
        
        // Create a chat with a new user

    
//       private func fetchChatInfo(chatId: String) async throws -> Chat {
//           let db = Firestore.firestore()
//           let chatRef = db.collection("Chats").document(chatId)
//           let document = try await chatRef.getDocument()
//           guard let data = document.data(), document.exists else {
//               throw NSError(domain: "ChatError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Chat does not exist"])
//           }
//           return Chat(user: <#User#>, chatId: chatId)
//           // Map other necessary fields from the document to your Chat struct or class
//       }
   }

