//
//  MessagesTabBar.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import SwiftUI

struct MessagesTabBar: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                Messages()
                    .onTapGesture{
                        selectedIndex = 0
                    }
                    .tabItem { Image(systemName: "bubble.left")}
                    .tag(0)
                Channels()
                    .onTapGesture{
                        selectedIndex = 1
                    }
                    .tabItem { Image(systemName: "rectangle.3.group.bubble.left")}
                    .tag(1)
            }
            .navigationTitle(tabTitle)
        }
    }
    
    
    var tabTitle: String {
        switch selectedIndex{
        case 0: return "Chats"
        case 1: return "Channels"
        default:return ""
        }
    }
}
struct MessagesTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MessagesTabBar()
    }
}
