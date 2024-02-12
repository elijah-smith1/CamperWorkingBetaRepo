//
//  Product.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Product: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var category: String
    var description: String
    var image: String
    var price: Int

}

var productList = [
    Product(name: "Tee-Shirt", category: "AUCS", description: "Cool la rolling tray", image: "vendor1", price: Int(35.99)),
    Product(name: "shorts", category: "AUCS", description: "cool la papers", image: "vendor2", price: Int(84.99)),
    Product(name: "shoes", category: "AUCS", description: "one la pack", image: "vendor3", price: Int(44.99)),
    Product(name: "Hoodies", category: "AUCS", description: "cool la grinder", image: "vendor4", price: Int(80.00)),
    Product(name: "other Product", category: "AUCS", description: "cool la rolling tray", image: "vendor5", price: Int(85.99)),
    Product(name: "LaceFront Install", category: "hair", description: "cool la lace", image: "vendor6", price: Int(85.99)),
    Product(name: "Chips", category: "store", description: "cool la chips", image: "vendor7", price: Int(45.99)),
    Product(name: "Shirt", category: "clothes", description: "cool la shirt", image: "vendor8", price: Int(35.99)),
    Product(name: "Shirt", category: "clothes", description: "cool la shirt again", image: "vendor9", price: Int(45.05)),

]
