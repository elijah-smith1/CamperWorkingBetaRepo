//
//  SignIn.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/9/23.
//

import SwiftUI
import FirebaseAuth

struct SignIn: View {
    
    @ObservedObject var viewModel = AuthViewModel()
    
    @Environment(\.colorScheme) var colorScheme
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    @State private var loginSuccessful: Bool = false

    var body: some View{
        if loginSuccessful{
            tabBar()
        } else {
            content
        }
    }
    var content: some View {
        NavigationStack {
            VStack {
                Image(colorScheme == .dark ? "OnCampDark" : "OnCampLight")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 320,height: 120)
                    .padding()
                
                HStack {
                    Text("Welcome")
                    Text("On")
                        .foregroundColor(Color.blue)
                        .padding(.trailing, -5.0)
                    Text("Camp!")
                    
                }
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                Spacer()
                VStack {
                    TextField("Enter Your Email", text: $email)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal,24)
                    SecureField("Enter Your Password", text: $password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal,24)
                }
                
                
                NavigationLink{
                    forgotPassword()
                }   label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                        .foregroundColor(Color("LTBL"))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                Spacer()
                
                Button {
                    login()
                }label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .cornerRadius(8)
                        .background(.blue)
                }
                Spacer()
                
                Divider()
                    .foregroundColor(Color("LTBL"))
                
                NavigationLink{
                    SignUp()
                }   label: {
                    HStack{
                        Text("Don't have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(Color("LTBL"))
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
        }
    }
        func login() {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    // Handle login error
                    
                    self.alertMessage = error.localizedDescription
                    print(self.alertMessage)
                    self.showAlert = true
                } else {
                    // Login successful, proceed to MainView
                    
                    self.loginSuccessful = true
                    print("sign in succesful")
                }
            }
        }
        
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Group
            {
                SignIn()
                    .preferredColorScheme(.light)
                SignIn()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
