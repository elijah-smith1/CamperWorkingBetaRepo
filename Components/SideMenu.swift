//
//  SideMenu.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/16/23.
//

import SwiftUI

struct SideMenu: View {
    let user: User?

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.mint]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                SideMenuHeader(user: user!) // Updated to remove the binding
                    .frame(height: 240)
                
                SideMenuOptions()
                
                Spacer()
            }
            .foregroundColor(Color("LTBLALT")) // Make sure you have this color defined in your assets
        }
    }
}

// Uncomment this for previewing the SideMenu
// struct SideMenu_Previews: PreviewProvider {
//     static var previews: some View {
//         SideMenu()
//     }
// }
