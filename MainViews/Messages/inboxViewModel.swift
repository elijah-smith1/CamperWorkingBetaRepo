//
//  inboxViewModel.swift
//  OnCampApp
//
//  Created by Elijah Smith on 11/17/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore


@MainActor
class inboxViewModel: ObservableObject{
    @Published var recentMessages: [Message] = []
    
    init(){
        Task {
            do {
                let chatIds = try await fetchChatIds()
                let recentMessages = try await fetchMostRecentMessages(forChatIds: chatIds)
                self.recentMessages = recentMessages
                    // Use the retrieved recent messages
                
                    print("Recent Messages: \(recentMessages)")
                // Use the retrieved chatIds
                print("Chat IDs: \(chatIds)")
            } catch {
                // Handle error
                print("Error fetching chat IDs: \(error)")
            }
            
        }
    }
    let db = Firestore.firestore()

       func fetchChatIds() async throws -> [String] {
           // Reference to the user's chats subcollection
           let userChatsRef = db.collection("Users").document(loggedInUid!).collection("chats")

           let snapshot = try await userChatsRef.getDocuments()

           return snapshot.documents.compactMap { document -> String? in
               // Assuming 'chatId' is a field in each document
               
               return document.get("chatId") as? String
               
              
           }
         
       }


  
       

        // Function to fetch the most recent message for each chatId
      
    func fetchMostRecentMessages(forChatIds chatIds: [String]) async throws -> [Message] {
        var recentMessages: [Message] = []

        for chatId in chatIds {
            let chatRef = db.collection("Chats").document(chatId)
            let messagesRef = chatRef.collection("messages")

            let querySnapshot = try await messagesRef
                .order(by: "timestamp", descending: true)
                .limit(to: 1)
                .getDocuments()

            if let document = querySnapshot.documents.first {
                var message = try document.data(as: Message.self)
                message.chatId = chatId  // Set the chat ID

                let chatDocument = try await chatRef.getDocument()
                if let participants = chatDocument.get("participants") as? [String] {
                    message.otherParticipantId = participants.first { $0 != loggedInUid }
                }

                recentMessages.append(message)
            }
        }

        return recentMessages
    }


}
