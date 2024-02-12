//
//  DeleteAccount.swift
//  OnCampApp
//
//  Created by Michael Washington on 1/28/24.
//


import SwiftUI
import Firebase

struct DeleteAccountButton: View {
    var body: some View {
        Button("Delete Account") {
            signOut()
        }
        .foregroundColor(.red)
    }
    func signOut() {
        do {
            try Auth.auth().signOut()
            
            // Successful sign-out
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
            
        }
    }

}

struct DeleteAccountButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountButton()
    }
}
