//
//  CreateMessage.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import SwiftUI

struct CreateMessage: View {
    @StateObject var viewmodel = NewMessageViewModel()
    @Binding var showChatView: Bool
    @Environment(\.presentationMode) var mode
    @State private var searchText = ""
/* add in groupchat functionality to this code*/
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return viewmodel.users
        } else {
            return viewmodel.users.filter { $0.username.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(filteredUsers, id: \.username) { user in
                        UserChatCell(user: user)
                        Divider()
                    }
                }
            }
            .navigationTitle("New Message")
            .padding()

            // Button for creating a group chat
            Button(action: {
              
            }) {
                NavigationLink(destination: CreateGroupChat()) {
                    Text("Create Group Chat")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    
                }

            }
            .padding()
        }
        .searchable(text: $searchText, prompt: "Search Users")
        .onSubmit(of: .search, {
            // Handle search submission if needed
        })
    }
}

struct CreateMessage_Previews: PreviewProvider {
    static var previews: some View {
        CreateMessage(showChatView: .constant(false))
    }
}
