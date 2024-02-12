//
//  MessageCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import SwiftUI


class MessageCellViewModel: ObservableObject {
    @ObservedObject var message = MessageData()
    @Published var username: String = ""
    
    func loadUsername(otherParticipantId: String) {
        Task {
            do {
                let fetchedUsername = try await message.fetchUsername(for: otherParticipantId)
                DispatchQueue.main.async {
                    self.username = fetchedUsername
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct MessageCell: View {
    @StateObject private var viewModel = MessageCellViewModel()
    let message: Message

    
    var body: some View {
        let chatId = message.chatId!
        NavigationLink(destination: Chat(chatId: chatId)){
            VStack {
                HStack {
                    CircularProfilePictureView()
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(viewModel.username.isEmpty ? "Loading..." : viewModel.username)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }
                        Text(message.content)
                            .font(.system(size: 15))
                    }
                    .foregroundColor(Color("LTBL"))
                    
                    Spacer()
                }
                .padding(.horizontal)
                .onAppear {
                    viewModel.loadUsername(otherParticipantId: message.otherParticipantId ?? "")
                }
                
                Divider()
            }
            .padding(.top)
        }
    }
}


//struct MessageCell_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageCell()
//    }
//}
