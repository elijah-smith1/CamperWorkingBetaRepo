//
//  CustomChatInput.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import SwiftUI

struct CustomChatInput: View {
    @Binding var text: String
    
    var action: () -> Void
    
    var body: some View {
        VStack{
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)
            HStack {
                TextField("Message...", text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.body)
                    .frame(minHeight: 30)
                
                Button(action: action, label: {
                    Text("Send")
                        .bold()
                        .foregroundColor(Color("LTBL"))
                })
            }
            .padding(.bottom,8)
            .padding(.horizontal)
        }
    }
}

