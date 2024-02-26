//
//  CategoryModel.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 1/25/24.
//

import Foundation

class CategoryListModel: ObservableObject {
    @Published var categories = categoryList
}

struct CategoryModel: Identifiable, Hashable {
    var id: UUID = .init()
    var icon: String
    var name: String
}

var categoryList: [CategoryModel] = [
    CategoryModel(icon: "xmark.diamond", name: "Tees"),
    CategoryModel(icon: "xmark.diamond", name: "Hoodies"),
    CategoryModel(icon: "xmark.diamond", name: "Bracelets"),
    CategoryModel(icon: "xmark.diamond", name: "Helmets"),
    CategoryModel(icon: "xmark.diamond", name: "Art"),
    CategoryModel(icon: "xmark.diamond", name: "Stickers")
]
