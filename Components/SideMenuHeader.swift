//
//  SideMenuHeader.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/16/23.
//

import SwiftUI

struct SideMenuHeader: View {
    @Environment(\.dismiss) var dismiss
    let user: User?
    @StateObject var viewModel: ProfileViewModel
    init(user: User) {
           self.user = user
           _viewModel = StateObject(wrappedValue: ProfileViewModel(userId: user.id ?? ""))
       }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(.primary)
                }
                Spacer()
                
                Spacer()
                
                CircularProfilePictureView(profilePictureURL: user?.pfpUrl)
                    .frame(width: 80, height: 80)
            }
            
            HStack {
                Spacer()
                
                Text(user!.username)
                    .font(.system(size: 24, weight: .semibold))
                
                Image(systemName: "v.circle.fill")
                    .foregroundColor(Color("OnCampSky"))
            }
            
            HStack(spacing: 12) {
                Spacer()
                
                HStack(spacing: 4) {
                    Text("\(viewModel.followerCount)").bold()
                    Text("Followers")
                }
                HStack(spacing: 4) {
                    Text("\(viewModel.followingCount)").bold()
                    Text("Following")
                }
            }
            Spacer()
        }
        .padding()
    }
}

// Uncomment for preview
// struct SideMenuHeader_Previews: PreviewProvider {
//     static var previews: some View {
//         SideMenuHeader()
//     }
// }
