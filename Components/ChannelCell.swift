//
//  ChannelCell.swift
//  OnCampApp
//
//  Created by Michael Washington on 10/17/23.
//

import SwiftUI

struct ChannelCell: View {
    var body: some View {
        HStack {
            CircularProfilePictureView()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text("Channel")
                    .fontWeight(.semibold)
                
                Text("16m ago")
            }
            .font(.footnote)
            
            Spacer()
            
            Text("1")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(width: 100, height: 32)
                .overlay {
                    Circle()
                        .stroke(Color("LTBL"), lineWidth: 1)
                }
        }
        .padding(.horizontal,43)
    }
}

struct ChannelCell_Previews: PreviewProvider {
    static var previews: some View {
        ChannelCell()
    }
}
