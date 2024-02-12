//
//  UserModel.swift
//  OnCampApp
//
//  Created by Elijah Smith on 11/7/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
struct User: Identifiable, Hashable, Codable {
        @DocumentID var id: String?  // Conforming to Identifiable
        var username: String
        var bio: String
        var status: String
        var school: String
        var interests: [String]?
        var pfpUrl: String?
        var followerCount: Int?
        var favorites: Int?
        var followingCount: Int?
        var isVendor: Bool
}
