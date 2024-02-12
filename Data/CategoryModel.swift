//
//  CategoryModel.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import Foundation

struct CategoryModel: Identifiable, Hashable {
    var id: UUID = .init()
    var icon: String
    var title: String
}

var categoryList: [CategoryModel] = [
    CategoryModel(icon: "", title: "All"),
    CategoryModel(icon: "hair", title: "Hair"),
    CategoryModel(icon: "clothes", title: "Clothes"),
    CategoryModel(icon: "store", title: "Store"),
    CategoryModel(icon: "AUCS", title: "AUCS"),
]
