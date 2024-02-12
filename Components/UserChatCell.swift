import SwiftUI

struct UserChatCell: View {
    @StateObject var viewmodel = NewMessageViewModel()
    let user: User
    @State var chatId: String?
    @State private var shouldNavigate = false  // State variable to control navigation
/*make these comptible for group chats*/
    var body: some View {
        NavigationStack {
            VStack {
                // Invisible NavigationLink, activated by the shouldNavigate state
              
                    NavigationLink(destination: Chat( chatId: chatId ?? "fuckedup"), isActive: $shouldNavigate) {
                        EmptyView()
                    }
                
                // User information and tap gesture
                HStack {
                    CircularProfilePictureView()
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.username)
                            .font(.system(size: 14, weight: .semibold))
                        
                        Text(user.status)
                            .font(.system(size: 15))
                    }
                    .font(.footnote)
                    .foregroundColor(Color("LTBL"))
                    
                    Spacer()
                }
                .padding(.horizontal)
                .onTapGesture {
                    let selectedUserId = user.id
                    print("Selected User ID: \(String(describing: selectedUserId))")
                    Task {
                        do {
                            let newChatId = try await viewmodel.createOrRetrieveChatDocument(for: selectedUserId!)
                            print("New Chat ID: \(newChatId)")
                            DispatchQueue.main.async {
                                self.chatId = newChatId
                                print("Assigned Chat ID: \(String(describing: self.chatId))")
                                
                            }
                        } catch {
                            print("Error creating chat document: \(error)")
                        }
                    }
                }

            }
            .padding(.top)
            .onChange(of: chatId) { newChatId in
                if newChatId != nil {
                    self.shouldNavigate = true
                }
            }
        }
    }
}
