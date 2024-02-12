import Foundation

@MainActor
class MarketplaceViewModel: ObservableObject {
    @Published var vendorsByCategory: [String: [Vendor]] = [:]
    private var vendorData = VendorData() // Assuming this contains the necessary methods

    // Initializer
    init() {
        Task {
            await fetchVendors()
        }
    }

    // Asynchronously fetch vendors and organize them by category
    private func fetchVendors() async {
        do {
            let vendorIds = try await vendorData.fetchVendorIds()
            var fetchedVendors: [Vendor] = []
            
            for vendorId in vendorIds {
                let vendor = try await vendorData.getVendorData(vendorID: vendorId)
                fetchedVendors.append(vendor)
            }

            // Organizing fetched vendors by category
            organizeVendorsByCategory(vendors: fetchedVendors)

        } catch {
            // Handle any errors
            print("Error fetching vendors: \(error.localizedDescription)")
        }
    }

    // Helper function to organize vendors into categories
    private func organizeVendorsByCategory(vendors: [Vendor]) {
        for vendor in vendors {
            vendorsByCategory[vendor.category, default: []].append(vendor)
        }
    }
}
