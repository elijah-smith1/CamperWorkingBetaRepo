import SwiftUI
import Firebase
import FirebaseAuth

@MainActor
class tabViewModel: ObservableObject {
    @Published var userData = UserData()
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    init() {
        fetchCurrentUserIfNeeded()
    }
     func fetchCurrentUserIfNeeded() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("No current user UID found")
            return//
        }//
        Task {//
            do { //
                try await userData.fetchUserData(Uid: uid) //
                DispatchQueue.main.async { [weak self] in //
                    self?.isLoading = false //
                } //
            } catch { //
                print("Error fetching current user data: \(error)") //
                DispatchQueue.main.async { [weak self] in //
                    self?.errorMessage = error.localizedDescription //
                    self?.isLoading = false //
                }//
            }//
        }//
    } ///
}//
