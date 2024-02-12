//
//  DetailedPostCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/23/23.
//

import SwiftUI
import Firebase
import Kingfisher


struct DetailedPostCell: View {
    var post: Post
    
    @State var likeCount: Int
    @State var repostCount: Int
    @State var isLiked: Bool
    @State var isReposted: Bool
    var body: some View {
        let postId = post.id

        VStack(alignment: .leading, spacing: 8) {
            HStack {
                CircularProfilePictureView(profilePictureURL: post.pfpUrl)
                    .frame(width: 64, height: 64)

                VStack(alignment: .leading, spacing: 2) {
                    Text(post.username)
                        .font(.headline)

                    Text("15m ago")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }

                Spacer()
            }
            .padding(.top, 16)

            Text(post.postText)
                .multilineTextAlignment(.leading)
                .padding(.top, 8)
            
            if let mediaUrl = post.mediaUrl, let url = URL(string: mediaUrl) {
                                      KFImage(url)
                                          .resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(width: 300, height: 200)
                                          .clipped()
                                          .cornerRadius(8)
                                          .padding(.top, 5)
                                  }

            HStack(spacing: 20) {
                Button {
                    isLiked.toggle() // Toggle the liked status
                    if isLiked{
                        likeCount+=1
                    }else {
                        likeCount-=1
                    }
                        PostData.shared.likePost(postID: post.id!)
                        // For example, call a function to update the like status in the database or send a network request.
                } label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .red : Color("LTBL")) // Change heart color based on like status.
                }

                Button {
                    isReposted.toggle()
                    PostData.shared.repostPost(postID: post.id!)
                    if isReposted{
                        repostCount+=1
                    }else {
                        repostCount-=1
                    }
                    // Handle button action here
                } label: {
                    Image(systemName: isReposted ? "arrow.rectanglepath": "arrow.rectanglepath")
                        .foregroundColor(isReposted ? .green : .white)
                }
                Button {
                    // Handle button action here
                } label: {
                    Image(systemName: "paperplane")
                }

                Spacer()

                Text("\(likeCount) likes • \(repostCount) reposts • \(post.commentCount) comments")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            .padding([.top, .leading], 16)

            Divider()
        }
        .foregroundColor(Color("LTBL"))
    }
}




//struct DetailedPostCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedPostCell(
//                        postText: "This is a sample post text",
//                          likeCount: 42,
//                          repostCount: 18,
//                          commentCount: 7,
//                          posterUid: "sampleuser123",
//                          username: "x",
//                          postedAt: Date(),
//                          postId: "4ljhkGhegmkmeHmLMmL2",
//                          userId: "defaultUserId")
//    }
//}
