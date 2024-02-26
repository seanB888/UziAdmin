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
    func addProduct(_ product: Product, withCategory category: CategoryModel) {
        var newProduct = product
        newProduct.category = category.name // Assigning the selected category's name to the product
                
        do {
            let _ = try db.collection("products").addDocument(data: newProduct.toDocument())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Updates an existing product in Firestore
    func updateProduct(_ product: Product) {
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
