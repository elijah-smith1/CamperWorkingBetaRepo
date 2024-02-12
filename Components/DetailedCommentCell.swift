//
//  DetailedComment.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/23/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore



struct DetailedCommentCell: View {
    
    @StateObject var postData = PostData()
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                CircularProfilePictureView(profilePictureURL: comment.pfpUrl!)
                    .frame(width: 32, height: 32)
                    .padding(.leading, 16.0)

                Text((comment.username!.isEmpty ? "Loading..." : comment.username!))
                    .font(.footnote)
                    .fontWeight(.semibold)

                Spacer()

                Text(PostData.shared.relativeTimeString(from: comment.timeSent))
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.trailing, 16.0)
            }
            .padding(.top, 8.0)

            Text(comment.text)
                .font(.body)
                .padding(.leading, 16.0)

            HStack {
                
                Text("View Replies here")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.leading, 16.0)
                
                Spacer()

                Text("like count here")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing, 16.0)

                Image(systemName: "heart")
                    .imageScale(.small)

                Image(systemName: "paperplane")
                    .imageScale(.small)
                    .padding(.trailing, 16.0)
            }
       



            Divider()
        }
        .padding(.horizontal)
    }
}

struct DetailedCommentCell_Previews: PreviewProvider {
    static var previews: some View {
        let sampleTimestamp = Timestamp(date: Date())
        return DetailedCommentCell(comment: Comment(id: "", commenterUid: "", text: "Text", timeSent: sampleTimestamp, commentReposts: 0, commentLikes: 0))
    }
}
