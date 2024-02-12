//
//  ProductCard.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import SwiftUI

struct ProductCard: View {
    var product: Product
    
    var body: some View {
        ZStack{
            Image(product.image)
                .resizable()
                .scaledToFit()
                .padding(.trailing, -200)
                .rotationEffect(Angle(degrees: 30))
            
            ZStack {
                VStack(alignment: .leading, content: {
                    Text("\(product.name)")
                        .font(.system(size: 36, weight: .semibold))
                        .frame(width: 140)
                    
                    Text(product.category)
                        .font(.callout)
                        .padding()
                        .background(.white.opacity(0.5))
                        .clipShape(Capsule())
                    Spacer()
                    
                    HStack{
                        Text("$\(product.price).0")
                            .font(.system(size:24, weight: .semibold))
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "basket")
                                .imageScale(.large)
                                .frame(width: 90,height: 68)
                                .background(.black)
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.leading)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background(.white.opacity(0.8))
                    .clipShape(Capsule())
                    
                })
            }
            .padding(30)
            .frame(width: 336, height: 422)
        }
        .frame(width: 336, height: 422)
        
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.leading,20)
    }
}
    
    struct ProductCard_Previews: PreviewProvider {
        static var previews: some View {
            ProductCard(product: Product(name: "Sample Product", category: "Sample Category", description: "", image: "sample_image", price: 0))
        }
    }
