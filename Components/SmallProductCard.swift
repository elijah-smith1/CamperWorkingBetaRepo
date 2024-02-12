//
//  SmallProductCard.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import SwiftUI

struct SmallProductCard: View {
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
                        .font(.system(size: 18, weight: .semibold))
                        .frame(width: 70)
                    
                    Text(product.category)
                        .font(.system(size:10))
                        .padding()
                        .background(.white.opacity(0.5))
                        .clipShape(Capsule())
                    Spacer()
                    
                    HStack{
                        Text("$\(product.price).0")
                            .font(.system(size:14, weight: .semibold))
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "basket")
                                .imageScale(.large)
                                .frame(width: 45,height: 40)
                                .background(.black)
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.trailing, -12)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    .background(.white.opacity(0.8))
                    .clipShape(Capsule())
                    
                })
            }
            .padding(20)
            .frame(width: 170, height: 215)
        }
        .frame(width: 170, height: 215)
        
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .padding(.leading,10)
    }
}

struct SmallProductCard_Previews: PreviewProvider {
    static var previews: some View {
        SmallProductCard(product: Product(name: "Sample Product", category: "Sample Category", description: "", image: "sample_image", price: 0))
    }
}
