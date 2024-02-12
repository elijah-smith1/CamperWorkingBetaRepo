//
//  ForgotPassword.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/9/23.
//

import SwiftUI

struct forgotPassword: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var email: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Image(colorScheme == .dark ? "OnCampDark" : "OnCampLight")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 320, height: 120)
                    .padding()
                HStack {
                    Text("Forgot")
                    Text("My")
                        .foregroundColor(Color.blue)
                        .padding(.trailing, -5.0)
                    Text("Password")
                    
                }
                .font(.largeTitle)
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                
                Spacer()
                
                Spacer()
                
                Spacer()
                
                Spacer()
                
                VStack {
                    Spacer()
                    TextField("Enter Your Email", text: $email)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                        Spacer()
                    
                    Button(action: {
                        // Add your send email action here
                    }) {
                        Text("Send Email")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 352, height: 44)
                            .cornerRadius(8)
                            .background(.blue)
                    }
                    Spacer()
                    
                    Spacer()
                    
                    Spacer()
                    
                    Spacer()
                    
                    Divider()
                        .foregroundColor(Color("LTBL"))
                    
                    NavigationLink(destination: SignIn()) {
                        HStack{
                            Text("I'm an idiot I remember!")
                            Text("Sign In")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(Color("LTBL"))
                        .font(.footnote)
                    }
                    .padding(.vertical, 16)
                }
                Spacer()
                
                Spacer()
            }
        }
    }
}

struct forgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            forgotPassword()
                .preferredColorScheme(.light)
            forgotPassword()
                .preferredColorScheme(.dark)
        }
    }
}
