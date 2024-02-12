//
//  Landing.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/9/23.
//

import SwiftUI

struct Landing: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Image(colorScheme == .dark ? "OnCampDark" : "OnCampLight")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 320,height: 120)
                    .padding()
                
                Spacer()
                
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
                
                HStack{
                    Text("New to OnCamp?")
                        .foregroundColor(Color("LTBL"))
                    NavigationLink("Sign Up"){
                        SignUp()
                    }
                }
                .font(.title)
                .fontWeight(.bold)
                
                
                HStack{
                    Text("Have An Existing Account?")
                        .foregroundColor(Color("LTBL"))
                        .padding(.vertical, 24.0)
                    NavigationLink("Sign In"){
                        SignIn()
                    }
                }
                .font(.title2)
                
                Spacer()
                Spacer()
                
            }
        }
    }
}

struct Landing_Previews: PreviewProvider {
    static var previews: some View {
        Landing()
    }
}
