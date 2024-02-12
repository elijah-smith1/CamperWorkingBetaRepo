import SwiftUI
import Kingfisher

struct VendorDetail: View {
//    var products: [Product]
    let vendor: Vendor
    @State private var showAlert = false
    /* create the fetch products and the product screen*/
    /* snazz up  the screen a little*/
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 210) // Placeholder for the overlaid content
                        
                        Divider()
                        
                        // Your items grid and any other content goes here
                        Text("PRODUCTS")
                            .font(.largeTitle)
                            .padding(.horizontal)
                        
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(productList, id: \.id) { item in
                                SmallProductCard(product: item)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                VStack {
                    KFImage(URL(string: vendor.headerImage))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .clipped()
                        .edgesIgnoringSafeArea(.top)
                        .opacity(0.8)
                    
                    Spacer() // Ensures the header occupies the correct amount of space
                }
                
                VStack {
                    HStack{
                        VStack(alignment: .leading, spacing: 2) {
                            Text(vendor.name)
                                .font(.title)
                                .bold()
                                .foregroundColor(.black)
                            HStack{
                                StarRating(vendor: vendor)
                                
                                Button(action: {
                                    showAlert = true
                                }) {
                                    Image(systemName: "info.circle")
                                        .foregroundColor(.blue)
                                }
                                .alert(isPresented: $showAlert) {
                                    Alert(
                                        title: Text("Vendor Info"),
                                        message: Text("\(vendor.description)\nSchools Serviced: \(vendor.schools.joined(separator: ", "))"),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                            }
                            Spacer()
                            
                            Button(action: {
                                // Messaging logic here
                            }) {
                                Text("Message Vendor")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                        .padding([.leading, .bottom, .trailing])
                        .cornerRadius(15)
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        KFImage(URL(string: vendor.pfpUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 90, height: 90)
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    .frame(height: 180) // Fixed height to match the header image
                }
            }
            .navigationBarHidden(true)
        }
    }
}


//struct VendorDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        VendorDetail(
//
//        )
//    }
//}

