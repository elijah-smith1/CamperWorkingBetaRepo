import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct CreateAccount: View {
    var uid: String
    
    @ObservedObject var userData = UserData()
    
    @State private var showingAlert = false
    @State private var alertMessage: String = ""
    @State private var profileImage: UIImage?
    @State private var isActive: Bool = false
    @State private var isShowingImagePicker = false
    @State private var showSelectInterestPage = false
    @State private var isAccountCreated = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Create Your Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 35)
                
                if let selectedImage = profileImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.bottom, 5)
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.bottom, 5)
                }
                
                Button(action: {
                    self.isShowingImagePicker = true
                }) {
                    Text("Upload Profile Picture")
                        .font(.headline)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$profileImage, sourceType: .photoLibrary)
                }

                Form {
                    ScrollView{
                        Section(header: Text("Profile Information")) {
                            TextField("Username (Required)", text: $userData.username)
                            TextField("Biography (Max 150 characters)", text: $userData.bio)
                                .frame(height: 100)
                            Picker("Status", selection: $userData.status) {
                                ForEach(userData.statuses, id: \.self) { Text($0) }
                            }
                            Picker("School", selection: $userData.school) {
                                ForEach(userData.colleges, id: \.self) { Text($0) }
                            }
                        }
                    }
                }

                NavigationLink(destination: Interests(uid: self.uid), isActive: $isAccountCreated) {
                    Button(action: {
                        createAccount()
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .padding()
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 50)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("Got it!")))
                }
            }
            .padding()
            .navigationBarHidden(true)
            
        }
        .accentColor(.blue)
        .padding(.bottom, 5)
    }
    
    private func loadImage() {
        guard let _ = profileImage else {
            self.alertMessage = "Please select a profile picture"
            self.showingAlert = true
            return
        }
    }
    
    private func createAccount() {
        guard let profileImage = self.profileImage else {
            self.alertMessage = "Please select a profile picture"
            self.showingAlert = true
            return
        }

        uploadProfileImage(profileImage) { result in
            switch result {
            case .success(let url):
                self.saveUserData(pfpUrl: url.absoluteString)
            case .failure(let error):
                self.alertMessage = "Error uploading profile image: \(error.localizedDescription)"
                self.showingAlert = true
            }
        }
    }

    private func uploadProfileImage(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else {
            completion(.failure(NSError(domain: "CreateAccount", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])))
            return
        }

        let storageRef = Storage.storage().reference().child("profile_pictures/\(uid).jpg")
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url))
                } else {
                    completion(.failure(NSError(domain: "CreateAccount", code: 0, userInfo: [NSLocalizedDescriptionKey: "URL not found"])))
                }
            }
        }
    }

    private func saveUserData(pfpUrl: String) {
        let userRef = Firestore.firestore().collection("Users").document(uid)
        let userData = [
            "bio": userData.bio,
            "username": userData.username,
            "school": userData.school,
            "status": userData.status,
            "isVendor": userData.isVendor,
            "pfpUrl": pfpUrl
        ] as [String: Any]

        userRef.setData(userData) { error in
            if let error = error {
                self.alertMessage = "Error setting user data: \(error.localizedDescription)"
                self.showingAlert = true
            } else {
                print("User data saved successfully")
                self.isAccountCreated = true
            }
        }
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount(uid: "MN9JWn0N3IYlkDPVpjunmCZkwGz2")
    }
}
