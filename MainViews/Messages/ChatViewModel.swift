//
//  ChatViewModel.swift
//  OnCampApp
//
//  Created by Elijah Smith on 11/13/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatViewModel: ObservableObject {
    
    
    func sendMessage(chatId: String, messageContent: String) {
        let db = Firestore.firestore()
        let senderId = Auth.auth().currentUser!.uid
        
        // Define a dictionary to represent the message data
        let messageData: [String: Any] = [
            "senderId": senderId, // Use the current user's UID
            "content": messageContent, // Use the messageContent parameter
            "timestamp": Timestamp(date: Date()), // Use the current date and time
            "read": false // Initially, the message is not read

        ]
        
        // Reference to the chat document
        let chatRef = db.collection("Chats").document(chatId)
        
        // Add the message data to the messages subcollection of the chat
        chatRef.collection("messages").addDocument(data: messageData) { error in
            if let error = error {
                print("Error sending message: \(error)")
            } else {
                print("Message sent successfully\(messageData)")
            }
        }
    }
    
    func listenForMessages(forChat chatId: String, completion: @escaping ([Message]) -> Void) -> ListenerRegistration {
        let db = Firestore.firestore()
        let messagesRef = db.collection("Chats").document(chatId).collection("messages")

        let listener = messagesRef
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error listening for message updates: \(error?.localizedDescription ?? "No error")")
                    return
                }

                let messages = snapshot.documents.compactMap { document -> Message? in
                    do {
                        return try document.data(as: Message.self)
                    } catch {
                        print("Error decoding message: \(error)")
                        return nil
                    }
                }
                completion(messages)
            }

        return listener
    }
}
