
//
//  Menu.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/15/23.
//

import SwiftUI

struct VendorMenu: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                NavigationLink("Become a Vendor", destination: EmptyView())
                
                Spacer()
            }
            VStack{
                Divider()
                
                Spacer()
                
                NavigationLink("Go to VendorHub", destination: EmptyView())
                
                Spacer()
            }
            VStack{
                Divider()
                
                Spacer()
                
                NavigationLink("My Orders", destination: EmptyView())
                
                Spacer()
                
                Divider()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
    }
    
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        VendorMenu()
    }
}
