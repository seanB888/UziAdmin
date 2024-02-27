//
//  Product.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/23/24.
//

import Foundation

extension ProductModel {
    // Converts a Firestore document to a Product object
    init?(documentData: [String: Any]) {
        guard let id = documentData["id"] as? String,
              let title = documentData["title"] as? String,
              let description = documentData["description"] as? String,
              let category = documentData["category"] as? String,
              let price = documentData["price"] as? Double,
              let productImage = documentData["productImage"] as? [String],
              let productColor = documentData["productColor"] as? [String] else {
            return nil
        }

        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.price = price
        self.productImage = productImage
        self.productColor = productColor

        let sizesDict = documentData["productSizes"] as? [String: Int] ?? [:]
        self.productSizes = sizesDict.map { ProductSize(size: $0.key, quantity: $0.value) }

        let reviewsArray = documentData["reviews"] as? [[String: Any]] ?? []
        self.reviews = reviewsArray.compactMap { Review(data: $0) }
    }

    // Converts a Product object to a Firestore document
    func toDocument() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "description": description,
            "category": category,
            "price": price,
            "productImage": productImage,
            "productColor": productColor,
            "productSizes": productSizes.reduce(into: [String: Int]()) { $0[$1.size] = $1.quantity },
            "reviews": reviews.map { $0.toDocument() }
        ]
    }
}

extension Review {
    // Converts a Review object to a Firestore document format
    func toDocument() -> [String: Any] {
        return [
            "date": date,
            "rating": rating,
            "reviewerName": reviewerName,
            "text": text,
            "title": title
        ]
    }
}
