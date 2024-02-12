//
//  UserCell.swift
//  OnCampApp
//
//  Created by Elijah Smith on 11/18/23.
//

import SwiftUI

struct UserCell: View {
    let user: User
    
    var body: some View {
        NavigationLink(destination: Profile(user: user)){
        HStack {
            CircularProfilePictureView(profilePictureURL: user.pfpUrl)
                .frame(width: 64, height: 64)
            
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
    }
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: User(username: "Sample", bio: "Bio", status: "Sataus", school: "School", isVendor: false))
    }
}
