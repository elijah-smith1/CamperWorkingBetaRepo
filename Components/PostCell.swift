//
//  PostsCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/12/23.
//

/*
 
 */

import SwiftUI
import Firebase
import FirebaseFirestore
import Kingfisher

struct PostCell: View {
    @State private var isLiked: Bool = false
    @State private var isReposted: Bool = false
    @State private var user: User?
    @State var likeCount: Int = 0
    @State var repostCount: Int = 0
    var post: Post
    
    
    @StateObject var viewModel = PostCellViewModel()
    
    var body: some View {
        
            
            NavigationLink(destination: DetailedPosts(post: post, likeCount: likeCount, repostCount: repostCount, isLiked: isLiked, isReposted: isReposted)) {
                VStack {
                    HStack(alignment: .top, spacing: 12) {
                        CircularProfilePictureView(profilePictureURL: user?.pfpUrl)
                            .frame(width: 64, height: 64)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                if let user = user {
                                    NavigationLink(destination: Profile(user: user)) {
                                        Text(user.username ?? "usernamenowork" )/* make this a link to profiles*/
                                            .font(.footnote)
                                            .fontWeight(.semibold)
                                        Spacer()
                                    }
                                } else {
                                    Text("it no work"   )/* make this a link to profiles*/
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                
                                
                                Text(PostData.shared.relativeTimeString(from: post.postedAt))
                                    .font(.caption)
                                    .foregroundColor(Color("LTBL"))
                                
                                Button {
                                    // Handle button action here
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(Color("LTBL"))
                                }
                            }
                            
                            Text(post.postText)
                                .font(.footnote)
                                .multilineTextAlignment(.leading)
                            
                            if let mediaUrl = post.mediaUrl, let url = URL(string: mediaUrl) {
                                KFImage(url)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 300, height: 200)
                                    .clipped()
                                    .cornerRadius(8)
                                    .padding(.top, 5)
                            }
                            
                            HStack(spacing: 16) {
                                Text("\(likeCount) likes • \(repostCount) reposts •  comments")
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
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
                                    
                                    // Handle button action here
                                } label: {
                                    Image(systemName:   "bubble.right")
                                    
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
                            }
                            .foregroundColor(Color("LTBL"))
                            .padding(.vertical, 8)
                        }
                    }
                    
                    Divider()
                }.onAppear{
                    Task{
                        do{
                            isLiked = try await viewModel.fetchLikeStatus(postId: post.id!, userId: loggedInUid!)
                            isReposted = try await viewModel.fetchRepostStatus(postId: post.id!, userId: loggedInUid!)
                            likeCount = try await viewModel.fetchLikes(postID: post.id!)
                            repostCount = try await viewModel.fetchreposts(postID: post.id!)
                        }
                    }
                    
                }.onAppear {
                    Task {
                        do {
                            self.user = try await viewModel.fetchUser(for: post.postedBy)
                        } catch {
                            print("Failed to fetch user: \(error)")
                            // Handle the error appropriately, perhaps by setting an error state or showing an alert.
                        }
                    }
                    
                    
                }
                .padding()
            }
        }
    }

    


// Assuming DetailedPosts, CircularProfilePictureView, and UserData.fetchUser(by:) are defined elsewhere.


//struct PostCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCell(
//            postText: "This is a sample post text",
//            likeCount: 42,
//            repostCount: 18,
//            commentCount: 7,
//            posterUid: "sampleuser123",
//            username: "x",
//            postedAt: Date(),
//            postId: "Q5902F7R5zmKyVK08BYq",
//            userId: "defaultUserId" // Provide a default value for userId in the preview
//        )
//    }
//}
