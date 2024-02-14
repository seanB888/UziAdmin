//
//  Home.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/3/24.
//

import SwiftUI

struct Home: View {
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Text("Dashboard")
                        .font(.largeTitle)
                    
                    NavigationLink(destination: About()) {
                        Text("About Us.")
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.black)
                .navigationBarBackButtonHidden(true)
                .background(Color.theme.background)
                
                // MARK: - Create Button...
                Button {
                    // button action...
                    withAnimation(.easeInOut) {
                        showSheet = true
                    }
                } label: {
                    HStack {
                        Image(systemName: "plus")
                            .imageScale(.large)
                        
                        Text("Create Product")
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .foregroundStyle(Color.theme.accent)
                    .background(.black)
                    .clipShape(Capsule())
                }
                .sheet(isPresented: $showSheet) {
                            // Content of the sheet
                            CreateProduct()
                        }
            }
        }
    }
}

#Preview {
    Home()
}
