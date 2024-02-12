//
//  DetailedPosts.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/23/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore


 struct DetailedPosts: View {
    var post: Post
     @State var likeCount: Int
     @State var repostCount: Int
     @State var isLiked: Bool
     @State var isReposted: Bool
    @State private var commentText: String = ""
    @State private var comments: [Comment] = []
    @State private var listener: ListenerRegistration?
     
    var body: some View {
        let postId = post.id!
        VStack(alignment: .leading, spacing: 12) {
            ScrollView {
                DetailedPostCell(post: post, likeCount: likeCount, repostCount: repostCount, isLiked: isLiked, isReposted: isReposted)
                ForEach(comments, id: \.self) { comment in
                    DetailedCommentCell(comment: comment)
                }
            }

            HStack {
                
                Image(systemName: "quote.bubble")
                    .foregroundColor(Color("LTBL"))
                    .font(.system(size: 22))
                    .padding(.leading, 8)

                TextField("Post your reply", text: $commentText, onCommit: {
                    PostData.shared.createComment(postID: postId, commentText: commentText)
                    DispatchQueue.main.async {
                           commentText = ""
                       }
                    print(commentText)
                })

                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color("TweetBackground")) // Use a custom color for the background
                    .cornerRadius(15)

                Spacer()

                Button(action: {
                    PostData.shared.createComment(postID: postId, commentText: commentText)
                    commentText = ""
                    print(commentText)
                }) {
                    Text("Post")
                        .bold()
                        .foregroundColor(Color("LTBL"))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color("TweetButtonBackground")) // Use a custom color for the button background
                        .cornerRadius(15)
                }
                .padding(.trailing, 8)
            }
            .padding(.horizontal)
        }
        .onAppear {
            listener = PostData.shared.listenToComments(forPost: postId) { newComments in
                comments = newComments
            }
        }
        .onDisappear {
            listener?.remove()
        }
    }
}




//struct DetailedPosts_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedPosts()
//    }
//}
