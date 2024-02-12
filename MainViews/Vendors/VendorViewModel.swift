//
//  VendorViewModel.swift
//  OnCampApp
//
//  Created by Michael Washington on 1/17/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
class VendorViewModel: ObservableObject {
    @Published var products: [Product] = []
    private var db = Firestore.firestore()
   
   
    
    
     
    
//     func fetchAllProducts(forVendor vendorId: String) async throws -> [Product] {
//        let vendorProductsRef = db.collection("Vendors").document(vendorId).collection("Products")
//        let querySnapshot = try await vendorProductsRef.getDocuments()
//        
//        let products = try querySnapshot.documents.compactMap { document -> Product? in
//            try document.data(as: Product.self)
//        }
//        return products
//    }
}

