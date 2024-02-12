//
//  Cart.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import SwiftUI

struct Cart: View {
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    HStack{
                        
                        Text("Cart")
                            .font(.system(size: 30))
                            .padding(.trailing)
                       
                        
                        Spacer()
                        
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Text("3")
                                .imageScale(.large)
                                .padding()
                                .frame(width: 70, height: 90)
                                .background(.blue.opacity(0.5))
                                .clipShape(Capsule())
                        }
                        .foregroundColor(.black)
                        
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .imageScale(.large)
                                .padding()
                                .frame(width: 70, height: 90)
                                .overlay(RoundedRectangle(cornerRadius: 50).stroke().opacity(0.4))
                        }
                        
                    }
                    .font(.system(size: 30))
                    .padding(30)
                    
                    //cart products
                    VStack (spacing: 20) {
                        ForEach(productList) { item in
                            CartProductCard(product: item)
                        }
                    }
                    .padding(.horizontal)
                    //total amount
                    VStack{
                        HStack{
                            Text("Delivery + Tax")
                            Spacer()
                            Text("$4.00")
                                .font(.system(size: 24, weight: .semibold))
                        }
                        Divider()
                        
                        Text("Total Amount")
                            .font(.system(size:24))
                        
                        Text("USD 38.00")
                            .font(.system(size:36, weight: .semibold))
                    }
                    .padding(30)
                    .frame(maxWidth: .infinity)
                    .background(.blue.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .padding()
                    //button to make payment
                    
                    Button {
                        
                    }label: {
                        Text("Make Payment")
                            .frame(maxWidth: .infinity)
                            .frame(height: 80)
                            .background(.blue.opacity(0.5))
                            .font(.system(size: 20,weight: .semibold))
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                            .padding()
                    }
                }
            }
        }
    }
}
struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart()
    }
}
