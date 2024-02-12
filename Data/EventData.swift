//
//  EventData.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/30/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Event: Identifiable {
    @DocumentID var id: String?
    var title: String
    var host: String
    var location: String
    var participants: Int
    var ticketLinks: [String]
    var imageUrls: [String]?
    var features: [String]
    // Add other relevant properties here
}

@MainActor
class EventData: ObservableObject {

    func fetchEventIds() async throws -> [String] {
        var eventIds = [String]()
        let snapshot = try await Firestore.firestore().collection("Events").getDocuments()
        for document in snapshot.documents { eventIds.append(document.documentID) }
        print(eventIds); return eventIds
    }

    func getEventData(eventID: String) async throws -> Event {
        let db = Firestore.firestore()
        let eventRef = db.collection("Events").document(eventID)

        let document = try await eventRef.getDocument()
        
        guard let data = document.data(), document.exists else {
            throw NSError(domain: "EventError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
        }
        print("Debug::: \(data)")
        return Event(
            id: document.documentID,
            title: data["title"] as? String ?? "",
            host: data["host"] as? String ?? "",
            location: data["location"] as? String ?? "",
            participants: data["participants"] as? Int ?? 0,
            ticketLinks: data["ticketLinks"] as? [String] ?? [""],
            imageUrls:  data["imageUrls"] as? [String],
            features: data["features"] as? [String] ?? [""]
            // Map other fields similarly
        )
    }

    // Add other methods similar to VendorData for CRUD operations
}

let mockEvent = Event(
    id: "unique_event_id",
    title: "Campus Party",
    host: "Campus Events",
    location: "Central Hall",
    participants: 200,
    ticketLinks: ["http://ticketlink.com"],
    imageUrls: ["event_image_url"],
    features: ["fun", "girls", "more fun"]
    // Initialize other properties if needed
)
