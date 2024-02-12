//
//  DetailedMessage.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import SwiftUI

struct DetailedChatBubbles: View {
    var isFromCurrentUser: Bool
    let message: Message
    var body: some View {
        HStack{
            if isFromCurrentUser {
                Spacer()
                
                Text(message.content)
                    .padding(12)
                    .background(Color.blue)
                    .font(.system(size:15))
                    .clipShape(ChatBubble(isFromCurrentUser: true))
                    .foregroundColor(Color("LTBLALT"))
                    .padding(.leading, 100)
                    .padding(.horizontal)
            } else {
                HStack(alignment: .bottom){
                 Image("spelhouse")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height:32)
                        .clipShape(Circle())
                    Text(message.content)
                        .padding(12)
                        .background(Color(.systemGray5))
                        .font(.system(size:15))
                        .clipShape(ChatBubble(isFromCurrentUser: false))
                        .foregroundColor(Color("LTBL"))
                }
                .padding(.horizontal)
                .padding(.trailing,80)
                
                Spacer()
            }
        }
    }
}

//struct DetailedChatBubbles_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedChatBubbles(isFromCurrentUser: false)
//    }
//}
