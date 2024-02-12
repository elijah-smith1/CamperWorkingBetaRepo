//
//  SideMenuOptions.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/16/23.
//

import SwiftUI

struct SideMenuOptions: View {
    var body: some View {
        NavigationStack{
            VStack{
                HStack(spacing: 16) {
                    Spacer()
                    
                    Image(systemName: "v.circle.fill")
                        .frame(width: 24, height: 24)
                    
                    NavigationLink(destination: EmptyView(), label: {
                        Text ("Become a Vendor!")
                    })
                }
                .foregroundColor(Color(.white))
                
                Spacer()
                
                HStack(spacing: 16) {
                    Spacer()
                    
                    Image(systemName: "bag.fill")
                        .frame(width: 24, height: 24)
                    
                    NavigationLink(destination: EmptyView(), label: {
                        Text ("My Orders")
                    })
                }
                .foregroundColor(Color(.white))
                
                Spacer()
                
                HStack(spacing: 16) {
                    Spacer()
                    
                    Image(systemName: "storefront.fill")
                        .frame(width: 24, height: 24)
                    
                    NavigationLink(destination: EmptyView(), label: {
                        Text ("Go To VendorHub")
                    })
                }
                .foregroundColor(Color(.white))
                
                Spacer()
                
                Spacer()
            }
        }
    }
}

struct SideMenuOptions_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptions()
    }
}
