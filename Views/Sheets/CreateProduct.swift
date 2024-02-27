//
//  CreateProduct.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/3/24.
//

import SwiftUI

struct CreateProduct: View {
    @Environment(\.presentationMode) var goBack
    @EnvironmentObject private var viewModel: ProductViewModel
    @ObservedObject private var categoryListModel = CategoryListModel()
    @ObservedObject private var colorListModel = ColorListModel()
    @ObservedObject private var photoAccessHelper = PhotoAccessHelper()
    @State private var selectedCategoryIndex = 0
    @State private var showingCamera = false
    @State private var image: UIImage?
    @State var saveproduct = false
    // Text Feilds
    @State private var productTitle = ""
    @State private var productDescription = ""
    @State private var productPrice = 0.0
    @State private var productImage = [""]
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var productSize = [""]
    @State private var selection: Set<String> = []
    // Assuming you're using a simple array of String for colors
    @State private var selectedColors: Set<String> = []
    @State private var selectedCategory: String? = nil
    
    private var colorOptions = ["AccentColor", "ArmyGreen", "UZiBlue", "UZiDarkGray", "UZiMustard", "UZiNavy", "UZiRed", "UZiYellow", "UZiBrown", "UZiPurple", "UZiStoneWash"]
    
    private var categoryOptions = ["Tees", "Hoodies", "Bracelets", "Helmets", "Stickers", "Art"]
    
    
    
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
                
                // MARK: -Save product
                Button {
                    withAnimation(.easeInOut) {
                        saveproduct = true
                        let selectedCategory = categoryListModel.categories[selectedCategoryIndex]
                        // viewModel.addProduct()
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
                    
                    
                    // MARK: - Category picker...
                    Section(header: Text("Category").fontWeight(.semibold)) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(categoryOptions, id: \.self) { category in
                                    CategoryView(categoryName: category, isSelected: selectedCategory == category)
                                        .onTapGesture {
                                            selectedCategory = category
                                        }
                                }
                            }
                        }
                    }
                    
                    .padding(.horizontal)
                    
                    // MARK: - Color selection
                    Section(header: Text("Color").fontWeight(.semibold)) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(colorOptions, id: \.self) { colorName in
                                    ColorView(colorName: colorName, isSelected: selectedColors.contains(colorName))
                                        .onTapGesture {
                                            if selectedColors.contains(colorName) {
                                                selectedColors.remove(colorName)
                                            } else {
                                                selectedColors.insert(colorName)
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    
                    // Product Title
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
                    // Product Cost
                    CustomTextField(labelText: "Product Price", textFieldText: "Product Price", text: $productTitle)
                    Spacer()
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .foregroundStyle(.black)
        .navigationBarBackButtonHidden(true)
        .background(Color.theme.background)
        .environment(\.colorScheme, .light)
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

struct ColorView: View {
    var colorName: String
    var isSelected: Bool
    let colorTheme = Color.theme
    
    var body: some View {
        Text(colorName)
            .padding()
            .foregroundStyle(isSelected ? .white : .black)
            .background(isSelected ? colorTheme.color(from: colorName) : Color.clear)
            .cornerRadius(10)
    }
}

struct CategoryView: View {
    var categoryName: String
    var isSelected: Bool
    
    var body: some View {
        Text(categoryName)
            .padding()
            .background(isSelected ? Color.theme.accent : Color.clear)
            .cornerRadius(10)
    }
}
