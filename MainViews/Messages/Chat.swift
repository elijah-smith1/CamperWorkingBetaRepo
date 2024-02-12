import SwiftUI
import FirebaseFirestore

struct Chat: View {
  //  let user: User
    var chatId: String
    @StateObject var viewmodel = ChatViewModel()
    @State private var messageText = ""
    @State private var messages: [Message] = []  // Assuming Message is your message model
    @State private var listenerRegistration: ListenerRegistration?  // State variable for the listener registration

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(messages, id: \.id) { message in
                        DetailedChatBubbles(isFromCurrentUser: message.senderId == loggedInUid, message: message)
                    }
                }
            }

            CustomChatInput(text: $messageText, action: {
                viewmodel.sendMessage(chatId: chatId, messageContent: messageText)
                messageText = ""  // Clear the input field after sending
            })
        }
        //.navigationBarTitle(user.username)
        .padding(.vertical)
        .onAppear {
            print(self.chatId)
            listenerRegistration = viewmodel.listenForMessages(forChat: chatId) { messages in
                       self.messages = messages
                   }
               }
               .onDisappear {
                   listenerRegistration?.remove()
               }
    }
}

// Update your PreviewProvider accordingly
struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat(chatId: "chat")
    }
}
