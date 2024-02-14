//
//  CreateProduct.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/3/24.
//

import SwiftUI

struct CreateProduct: View {
    @State private var showingCamera = false
    @State private var image: UIImage?
    @Environment(\.presentationMode) var goBack
    @State var saveproduct = false
    // Text Feilds
    @State var productTitle = ""
    @State var productDescription = ""
    @State private var firstCategory = "Tees"
    var productCategory = ["Tees", "Bracelets", "Helemets", "Stickers"]
    @ObservedObject private var photoAccessHelper = PhotoAccessHelper()
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    
    
    var body: some View {
        VStack {
            // MARK: - Navbar
            HStack {
                Button {
                    goBack.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut) {
                        saveproduct = true
                    }
                } label: {
                    ZStack {
                        Text("Save")
                            .opacity(saveproduct ? 0 : 1)
                        
                        Image(systemName: "checkmark")
                            .opacity(saveproduct ? 1 : 0)
                    }
                    .foregroundStyle(Color.theme.accent)
                }
                .frame(width: 80, height: 30)
                .background(.black)
                .clipShape(Capsule())
            }
            .padding(.vertical, 25)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            
            Divider()
                .padding(.bottom)
            
            Text("Create A Product")
                .font(.title)
                .fontWeight(.bold)
            
            ScrollView {
                
                VStack(spacing: 10) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                    }
                    
                    // Upload image button
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Upload Images")
                            .font(.callout).fontWeight(.semibold)
                            .foregroundStyle(Color.theme.uziDarkGray)
                        Menu {
                            // Access photo gallery...
                            Button {
                                // button action...
                                withAnimation(.easeInOut) {
                                    // Action here to Access photo gallery
                                    withAnimation(.easeInOut) {
                                        showingImagePicker = true
                                    }
                                }
                            } label: {
                                Text("Upload Photos")
                                Image(systemName: "square.and.arrow.up.fill")
                            }
                            
                            // Access camera...
                            Button {
                                // button action...
                                withAnimation(.easeInOut) {
                                    // action to access camera here...
                                    showingCamera = true
                                }
                            } label: {
                                HStack {
                                    Text("Camera")
                                    Image(systemName: "camera")
                                }
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .stroke(Color.theme.uziDarkGray.opacity(0.7), style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                                    .foregroundStyle(.clear)
                                    .frame(width: 350, height: 100)
                                
                                Image(systemName: "plus.rectangle.fill.on.rectangle.fill")
                                    .font(.system(size: 30))
                                    .foregroundStyle(Color.theme.uziDarkGray.opacity(0.7))
                            }
                        }
                        .sheet(isPresented: $showingCamera) {
                            CameraView(image: $image)
                        }
                        .sheet(isPresented: $showingImagePicker) {
                            PhotoPicker(selectedImage: $selectedImage)
                        }
                    }
                    
                    CustomTextField(labelText: "Product Title", textFieldText: "Lion of Judah", text: $productTitle)
                    
                    // Product description...
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Product Description")
                            .font(.callout).fontWeight(.semibold)
                            .foregroundStyle(Color.theme.uziDarkGray)
                        
                        TextEditor(text: $productDescription)
                            .lineLimit(4)
                            .frame(height: 100)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.theme.uziDarkGray.opacity(0.3), style: StrokeStyle(lineWidth: 1))
                            )
                    }
                    .padding(.horizontal)
                    
                    // Category picker...
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Choose a Category")
                            .font(.callout).fontWeight(.semibold)
                            .foregroundStyle(Color.theme.uziDarkGray)
                        VStack {
                            Picker(selection: $firstCategory, label: Text("")) {
                                ForEach(productCategory, id: \.self) { name in
                                    Row(name: name)
                                }
                            }
                            .pickerStyle(.wheel)
                            Text("Selected: \(firstCategory)")
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .foregroundStyle(.black)
        .navigationBarBackButtonHidden(true)
        .background(Color.theme.background)
    }
}

#Preview {
    CreateProduct()
}

// MARK: Custom Text Field
struct CustomTextField: View {
    @State var labelText: String
    @State var textFieldText: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(labelText)
                .font(.callout).fontWeight(.semibold)
                .foregroundStyle(Color.theme.uziDarkGray)
            TextField(textFieldText, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.top, 10)
        .padding(.horizontal)
    }
}

fileprivate struct Row: View {
    var name: String
    
    var body: some View {
        HStack {
            Text(name)
        }
    }
}
