//
//  Notifications.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

struct Notification: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var senderName: String
    var notiType: String
    var post: String?
    var senderId: String
    var timestamp: Timestamp
}

class NotificationViewModel: ObservableObject {
    @Published var notifications = [Notification]()

    private var db = Firestore.firestore()

    func fetchNotifications(userId: String) {
        db.collection("Users").document(userId).collection("notifications")
            .order(by: "timestamp", descending: true) // Sorting by timestamp in descending order
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No documents in 'notifications' or error: \(error?.localizedDescription ?? "")")
                    return
                }

                self.notifications = documents.compactMap { queryDocumentSnapshot in
                    try? queryDocumentSnapshot.data(as: Notification.self)
                }
                print("DEBUG:: Notis \(self.notifications)")
            }
    }
}

struct NotificationsView: View {
    @StateObject var viewModel = NotificationViewModel()

    var body: some View {
        ScrollView {
            ForEach(viewModel.notifications, id: \.id) { notification in
                NotificationView(notification: notification)
            }
        }
        .onAppear {
            viewModel.fetchNotifications(userId: loggedInUid!) // Replace with actual user ID
        }
    }
}

struct NotificationView: View {
    var notification: Notification

    var body: some View {
        HStack {
            Image(systemName: "bell") // Placeholder icon for notification
                .foregroundColor(.gray)
                .padding(.trailing, 8)

            VStack(alignment: .leading) {
                Text(notification.senderName)
                    .font(.headline)
                Text(notificationDescription(for: notification.notiType))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Placeholder for the timestamp
            Text(PostData.shared.relativeTimeString(from: notification.timestamp))
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }

    private func notificationDescription(for type: String) -> String {
        switch type {
        case "NewFollower":
            return "started following you."
        case "NewLike":
            return "liked your post."
        case "NewRepost":
            return "reposted your post."
        case "NewComment":
            return "commented on your post."
        default:
            return "sent you a notification."
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
