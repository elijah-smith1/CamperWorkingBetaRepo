////
////  AuthData.swift
////  OnCampApp
////
////  Created by Michael Washington on 10/9/23.
////
//
import Foundation
import SwiftUI
import Firebase
import Combine
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var uid: String = ""

    func SignUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // Handle signup error
                print("Signup error: \(error)")
            } else {
                guard let currentUser = Auth.auth().currentUser else {
                    // Handle error
                    print("Error getting current user")
                    return
                }
                self.uid = currentUser.uid
                print("User UID: \(self.uid)")
            }
        }
    }
}
