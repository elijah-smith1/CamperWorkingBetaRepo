import SwiftUI

struct StarRating: View {
    var vendor: Vendor
    var maximumRating: Int = 5
    let onImage = Image(systemName: "star.fill")
    let offImage = Image(systemName: "star")
    let halfImage = Image(systemName: "star.leadinghalf.filled")
    
    func image(for number: Int) -> Image {
        if Double(number) > vendor.rating {
            return offImage
        } else if Double(number) > vendor.rating - 0.5 {
            return halfImage
        } else {
            return onImage
        }
    }

    var body: some View {
        HStack {
            ForEach(1...maximumRating, id: \.self) { number in
                self.image(for: number)
                    .foregroundColor(.yellow)
            }
        }
    }
}

//struct StarRating_Previews: PreviewProvider {
//    static var previews: some View {
//        StarRating(vendor: Vendor(id: nil, description: "Test Description", schools: ["Test School"], name: "Test Vendor", image: "test_image", category: "Test Category", rating: 3.5, featured: false))
//    }
//}
