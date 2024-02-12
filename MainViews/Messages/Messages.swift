import SwiftUI

struct Messages: View {
    @State private var showNewMessageView = false
    @State private var showChatView = false
    @StateObject var inboxviewModel = inboxViewModel() // Assuming InboxViewModel is the correct name

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Uncomment or remove NavigationLink as needed
            // NavigationLink(destination: Chat(), isActive: $showChatView){ }

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(inboxviewModel.recentMessages, id: \.id) { message in
                        
                        MessageCell(message: message) // Corrected variable name
                    }
                }
            }
            Button(action: {
                showNewMessageView.toggle()
            }, label: {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding()
            })
            .background(Color(.systemBlue))
            .foregroundColor(Color("LTBLALT")) // Ensure this color is defined
            .clipShape(Circle())
            .padding()
            .sheet(isPresented: $showNewMessageView, content: {
                CreateMessage(showChatView: $showChatView) // Ensure CreateMessage is correctly defined
            })
        }
    }
}

struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages()
    }
}
