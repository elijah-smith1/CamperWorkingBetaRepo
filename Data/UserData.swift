
// UserData.swift
// OnCampRelease
//
// Created by Michael Washington on 9/20/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestoreSwift
import FirebaseFirestore


/* remove Favorite*/

@MainActor
class UserData : ObservableObject {


   
    
// changed from "IsVendor" to "isVendor"
        @Published var isVendor = false
       @Published var school = ""
       @Published var username = ""
       @Published var bio = ""
       @Published var status = ""
       @Published var followingCount = 0
       @Published var followerCount = 0
       @Published var interests: [String] = []
       @Published var statuses: [String] = []
       @Published var colleges: [String] = []
       @Published var alertMessage: String = ""
       @Published var showingAlert: Bool = false
    
       var profileImage: UIImage?
       @Published var isLoggedIn: Bool = false
       @Published var currentUser: User?

    init() {
       
       
        
        self.colleges = [
            "Select a College",
            "Morehouse College",
            "Spelman College",
            "Clark Atlanta University",
            "Georgia State",
            "Georgia Tech"
        ] // List of colleges in Georgia

        self.statuses = [
            "Bored 😑",
            "Chilling 😎",
            "Drunk 🍻",
            "Excited 🤩",
            "Geeked 🤓",
            "Hanging Out 🤙",
            "Napping 😴",
            "Netflix and Chill 🍿",
            "Partying 🎉",
            "Procrastinating 🕒",
            "Socializing 🤝",
            "Stressed 😫",
            "Studying 📖",
            "Tired 😴",
            "Working 💼",
            "Exploring the City 🏙️",
            "Conquering the Books 📚",
            "Creating Art 🎨",
            "Hitting the Gym 💪",
            "Making Memories 📸",
            "Attending a Concert 🎶",
            "Hiking the Trails 🌲",
            "Cooking up a Storm 🍳",
            "Learning Something New 🧠",
            "Jamming with Friends 🎸",
            "Volunteering for a Cause ❤️",
            "Getting Lost in a Movie 🎥",
            "Traveling the World ✈️",
            "Solving Puzzles 🔍",
            "Working on Projects 💼",
            "Chasing Dreams ✨",
            "Relaxing by the Beach 🏖️",
            "Embracing the Nightlife 🌃"
            // Add more statuses here if needed
        ]
        self.interests = [
         "Staying in","Going out", "Eating out","Drinking",
        "Smoking", "Sports", "Reading", "Movies",
        "Music", "Gaming", "Writing", "Food",
        "Fashion", "Cars", "Parties", "Traveling", "Cooking", "Socializing",
        "Hiking", "Exercise", "Learning", "Concerts",
        "Art", "Tech", "Nature", "Dancing",
        "Photography", "Pets", "Adventure", "Beach",
        "Yoga", "Exploring", "Meditation", "Shopping",
        "Volunteering", "Singing", "Crafts", "Poetry"

        ]
        // Initialize Firebase and listen to authentication state changes
    }
    
   static func getFollowingDocumentIds() async throws -> [String] {
      // Replace with your actual constant

        // Reference to the Firestore collection
        let collectionReference = Firestore.firestore().collection("Users").document(loggedInUid!).collection("Following")

        // Fetch documents from the collection
        do {
            let querySnapshot = try await collectionReference.getDocuments()

            // Extract document IDs from the querySnapshot
            let documentIds = querySnapshot.documents.map { $0.documentID }
            
            return documentIds
        } catch {
            // Propagate the error
            throw error
        }
    }
    static func getFavoriteDocumentIds() async throws -> [String] {
       // Replace with your actual constant

         // Reference to the Firestore collection
         let collectionReference = Firestore.firestore().collection("Users").document(loggedInUid!).collection("Favorites")

         // Fetch documents from the collection
         do {
             let querySnapshot = try await collectionReference.getDocuments()

             // Extract document IDs from the querySnapshot
             let documentIds = querySnapshot.documents.map { $0.documentID }
             
             return documentIds
         } catch {
             // Propagate the error
             throw error
         }
     }

    
    func checkFollowingAndFavoriteStatus(selectedUid: String) async throws -> String  {
        let db = Firestore.firestore()

        guard let loggedInUid = loggedInUid else {
            throw NSError(domain: "AppError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Logged in user ID is nil"])
        }

        // Check if the selected user is the logged-in user
        if loggedInUid == selectedUid {
            let userRef = db.collection("Users").document(loggedInUid)

            do {
                let userDocument = try await userRef.getDocument()
                let isVendor = userDocument.data()?["isVendor"] as? Bool ?? false

                return isVendor ? "OwnVendorSelf" : "OwnSelf"
            } catch {
                throw error
            }
        } else {
            let loggedInUserFollowingRef = db.collection("Users").document(loggedInUid).collection("Following")
            let loggedInUserFavoritesRef = db.collection("Users").document(loggedInUid).collection("Favorites")

            do {
                // Check if the selected user is in the logged-in user's 'Following' sub-collection
                let followingDocument = try await loggedInUserFollowingRef.document(selectedUid).getDocument()
                let isFollowing = followingDocument.exists

                // Check if the selected user is in the logged-in user's 'Favorites' sub-collection
                let favoriteDocument = try await loggedInUserFavoritesRef.document(selectedUid).getDocument()
                let isFavorite = favoriteDocument.exists

                if isFollowing {
                    return isFavorite ? "FollowingAndFavorite" : "Following"
                } else {
                    return "NotFollowing"
                }
            } catch {
                throw error
            }
        }
    }


    func followOrUnfollowUser( selectedUid: String) async throws {
        let db = Firestore.firestore()

        guard let loggedInUid = loggedInUid else {
            throw NSError(domain: "AppError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Logged in user ID is nil"])
        }

        let loggedInUserRef = db.collection("Users").document(loggedInUid)
        let selectedUserRef = db.collection("Users").document(selectedUid)
        
        let loggedInUserFollowingRef = loggedInUserRef.collection("Following")
        let loggedInUserFavoritesRef = loggedInUserRef.collection("Favorites")
        let selectedUserFollowersRef = selectedUserRef.collection("Followers")

        do {
            let followingDocument = try await loggedInUserFollowingRef.document(selectedUid).getDocument()
            let isFollowing = followingDocument.exists

            // Remove from following and favorites if already following, else add
            if isFollowing {
                try await loggedInUserFollowingRef.document(selectedUid).delete()
                try await loggedInUserFavoritesRef.document(selectedUid).delete()
                try await selectedUserFollowersRef.document(loggedInUid).delete()
            } else {
                try await loggedInUserFollowingRef.document(selectedUid).setData([:])
               
                try await selectedUserFollowersRef.document(loggedInUid).setData([:])
            }
        } catch {
            throw error
        }
    }


    func favoriteOrUnfavoriteUser(selectedUid: String) async throws {
        let db = Firestore.firestore()

        guard let loggedInUid = loggedInUid else {
            throw NSError(domain: "AppError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Logged in user ID is nil"])
        }

        let loggedInUserRef = db.collection("Users").document(loggedInUid)
        let loggedInUserFavoritesRef = loggedInUserRef.collection("Favorites")

        do {
            let favoriteDocument = try await loggedInUserFavoritesRef.document(selectedUid).getDocument()
            let isFavorite = favoriteDocument.exists

            // If already a favorite, remove from favorites, else add to favorites
            if isFavorite {
                try await loggedInUserFavoritesRef.document(selectedUid).delete()
            } else {
                try await loggedInUserFavoritesRef.document(selectedUid).setData([:])
            }
        } catch {
            throw error
        }
    }


    
    func fetchUserData(Uid: String) async throws {
        print("fetchUserData() called")

        // Set a default UID if no user is logged in
    
        print("Using UID: \(Uid)")

        do {
            let documentSnapshot = try await Userdb.document(Uid).getDocument()
            print("Document snapshot fetched")

            guard let user = try? documentSnapshot.data(as: User.self) else {
                let decodeError = NSError(domain: "AppError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to decode user data."])
                print("Error decoding user data: \(decodeError)")
                throw decodeError
            }
            print("User data decoded successfully")

            DispatchQueue.main.async {
                       print("Updating UI on the main thread")
                       self.currentUser = user // Here we are assigning the fetched and decoded user data to currentUser
                       print("UI should be updated now")
                   }
        } catch {
            print("Error fetching document: \(error.localizedDescription)")
            throw error
        }
    }


    // Async function to fetch a user by userId
    static func fetchUser(by userId: String) async throws -> User? {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")

        // Attempt to retrieve the document
        let documentSnapshot = try await usersCollection.document(userId).getDocument()

        // Check if the document exists
        guard documentSnapshot.exists, let user = try? documentSnapshot.data(as: User.self) else {
            // Handle the case where the document does not exist or data can't be decoded
            return nil
        }

        // Return the User object
        return user
    }
    
    func fetchUser(for userId: String) async throws -> User {
        let userDocument = Userdb.document(userId)
        let documentSnapshot = try await userDocument.getDocument()

        let user: User
        do {
            user = try documentSnapshot.data(as: User.self)
        } catch {
            print("error fetching user: \(error)")
            throw error // Propagate the error upwards
        }
         
        return user
    }

}



