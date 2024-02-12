import SwiftUI

struct Marketplace: View {
    @State var selectedCategory = "All"
    @State private var searchText = ""
    @StateObject var viewModel = MarketplaceViewModel()
    let user: User?
/* make search functional*/
/* make featured functional*/
/* make everything functional*/
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Vendor")
                            .foregroundColor(.blue)
                            .padding(.trailing, -8.0)
                        Text("Hub")
                    }
                    .font(.title)

                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.blue)

                        TextField("Search for vendors...", text: $searchText)
                            .padding(8)

                        NavigationLink(destination: SideMenu(user: user)) {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 30))
                        }
                    }
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .padding(.horizontal)

                    // Categories Scroller
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(categoryList, id: \.id) { category in
                                Button(action: {
                                    selectedCategory = category.title
                                }) {
                                    CategoryItem(category: category, isSelected: selectedCategory == category.title)
                                }
                            }
                        }
                        .padding()
                    }
                    .background(Color.white)

                    // Dynamically create VendorSection views based on categories
                    ForEach(viewModel.vendorsByCategory.keys.sorted(), id: \.self) { category in
                        VendorSection(title: category, vendors: viewModel.vendorsByCategory[category] ?? [])
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

struct VendorSection: View {
    var title: String
    var vendors: [Vendor]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(vendors, id: \.name) { vendor in
                        VendorPreview(vendor: vendor)
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct CategoryItem: View {
    var category: CategoryModel
    var isSelected: Bool
    
    var body: some View {
        HStack {
            if category.title != "All" {
                Image(systemName: category.icon)
                    .foregroundColor(isSelected ? .white : .blue)
            }
            Text(category.title)
                .fontWeight(isSelected ? .bold : .regular)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
        .background(isSelected ? .blue : .gray.opacity(0.1))
        .foregroundColor(isSelected ? .white : .black)
        .clipShape(Capsule())
    }
}


//struct Marketplace_Previews: PreviewProvider {
//    static var previews: some View {
//        Marketplace()
//    }
//}

// Assuming Vendor, VendorData, and CategoryModel structs are defined elsewhere
