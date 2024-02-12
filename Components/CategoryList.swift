//
//  CategoryList.swift
//  OnCampApp
//
//  Created by Michael Washington on 11/4/23.
//

import SwiftUI

struct CategoryList: View {
    @State var selectedCategory = "All"
    let categories = categoryList // Use the array of CategoryModel instances you've provided.

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories) { item in
                    Button(action: {
                        selectedCategory = item.title
                    }) {
                        HStack {
                            if item.title != "All" {
                                Image(item.icon) //
                                    .foregroundColor(selectedCategory == item.title ? .blue : .black)
                            }
                            Text(item.title)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(selectedCategory == item.title ? .black : .gray.opacity(0.1))
                        .foregroundColor(selectedCategory != item.title ? .black : .white)
                        .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
    }
}


