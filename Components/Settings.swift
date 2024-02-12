//
//  Settings.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/14/23.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        NavigationStack {
            Form {
                

                Section(header: Text("Report Issue")) {
                    NavigationLink(destination: Text("Report Issue")) {
                        Text("Report Issue")
                    }
                }

                Section(header: Text("About")) {
                    NavigationLink(destination: Text("App Version: 1.0")) {
                        Text("App Information")
                    }
                }

                Section(header: Text("Legal")) {
                    NavigationLink(destination: Text("Terms and Conditions")) {
                        Text("Terms and Conditions")
                    }
                    NavigationLink(destination: Text("Privacy Policy")) {
                        Text("Privacy Policy")
                    }
                }
                
                Section(header: Text("Account")) {
                    Signoutbutton()
                    DeleteAccountButton()
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
