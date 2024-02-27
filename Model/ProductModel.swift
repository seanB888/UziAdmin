//
//  ProductModel.swift
//  Uzimmie
//
//  Created by SEAN BLAKE on 1/25/24.
//

import Foundation

struct ProductModel: Identifiable {
    var id: String
    var title: String
    var description: String
    var category: String
    var price: Double
    var productImage: [String]
    var productColor: [String]
    var productSizes: [ProductSize]
    var reviews: [Review]

    init(id: String, data: [String: Any]) {
        self.id = id
        self.title = data["title"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.category = data["category"] as? String ?? ""
        self.price = data["price"] as? Double ?? 0
        self.productImage = data["productImage"] as? [String] ?? []
        self.productColor = data["productColor"] as? [String] ?? []

        let sizesDict = data["productSizes"] as? [String: Int] ?? [:]
        self.productSizes = sizesDict.map { ProductSize(size: $0.key, quantity: $0.value) }

        let reviewsArray = data["reviews"] as? [[String: Any]] ?? []
        self.reviews = reviewsArray.compactMap { Review(data: $0) }
    }
}

struct ProductSize: Identifiable {
    var id = UUID()
    var size: String
    var quantity: Int
}

struct Review: Identifiable {
    var id = UUID()
    var date: String
    var rating: Int
    var reviewerName: String
    var text: String
    var title: String

    init(data: [String: Any]) {
        self.date = data["date"] as? String ?? ""
        self.rating = data["rating"] as? Int ?? 0
        self.reviewerName = data["reviewerName"] as? String ?? ""
        self.text = data["text"] as? String ?? ""
        self.title = data["title"] as? String ?? ""
    }
}
