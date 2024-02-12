//
//  EventPreview.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/29/23.
//

import SwiftUI

struct EventPreview: View {
    var images = [
        "Events1",
        "Events2",
        "Events3",
    ]
    
    var body: some View {
        NavigationLink(destination: DetailedEvent(EventTitle: "OnCamp Release Party", EventHost: "Best Parties ATL", EventLocation: "830 Westview Drive", EventParticipants: 520)){
            VStack(spacing: 8) {
                EventImageCaroseul()
                    .frame(height: 320)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("OnCamp Release Party")
                        
                        Text("2W 2D 6H 23M")
                            .font(.caption)
                        Text("Event Descripton")
                    }
                    .foregroundColor(Color("LTBL"))
                    
                    Spacer()
                    
                    HStack {
                        Text("$10 - 15")
                    }
                }
            }
        }
        .padding()
    }
}


struct EventPreview_Previews: PreviewProvider {
    static var previews: some View {
        EventPreview()
    }
}
