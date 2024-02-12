//
//  CartProductCard.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import SwiftUI

struct CartProductCard: View {
    
    var product: Product
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .padding()
                .frame(width:80, height:80)
                .background(.gray.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading, content: {
                Text("\(product.name)")
                    .font(.headline)
                
                Text(product.category)
                    .font(.callout)
                    .opacity(0.5)
            })
            Spacer()
            Text("$\(product.price)")
                .padding()
                .background(.blue.opacity(0.5))
                .clipShape(Capsule())
            
        }
    }
}


struct CartProductCard_Previews: PreviewProvider {
    static var previews: some View {
        CartProductCard(product: Product(name: "Sample Product", category: "Sample Category", description: "", image: "sample_image", price: 0))
    }
}
