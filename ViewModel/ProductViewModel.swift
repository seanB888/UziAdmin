//
//  ProductViewModel.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/23/24.
//

import Foundation
import FirebaseFirestore

class ProductViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    // Adds a new product to Firestore
    func addProduct(_ details: ProductModel, withSKU sku: String, image: UIImage?) {
        // Prepare data dictionary for Firestore
        var productData: [String: Any] = [
            "title": details.title,
            "description": details.description,
            "price": details.price,
            "category": CategoryListModel.self,
            "colors": ColorListModel.self,
            "SKU": sku
            // Include other relevant fields
        ]
        
        // Convert UIImage to a suitable format for storage if needed
        
        // Add to Firestore
        let db = Firestore.firestore()
        db.collection("products").addDocument(data: productData) { error in
            if let error = error {
                print("Error saving product: \(error.localizedDescription)")
            } else {
                print("Product added successfully with SKU: \(sku)")
                // Handle any follow-up actions
            }
        }
    }
    
    // Updates an existing product in Firestore
    func updateProduct(_ product: ProductModel) {
        db.collection("products").document(product.id).updateData(product.toDocument()) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    // Deletes a product from Firestore
    func deleteProduct(_ productId: String) {
        db.collection("products").document(productId).delete() { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed")
            }
        }
    }
}
