//
//  About.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/3/24.
//

import SwiftUI

struct About: View {
    @Environment(\.presentationMode) var goBack
    
    var body: some View {
        NavigationStack {
            // MARK: - Header
            VStack {
                HStack {
                    Button {
                        // button action here...
                        goBack.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .padding(.horizontal)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
                Text("About")
                    .font(.largeTitle)
                Spacer()
                
                // MARK: - Footer
                HStack(spacing: 3) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 10))
                        .foregroundStyle(.purple)
                    Text("**Ucleus** 2024 | v: 0.0.1")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.black)
            .background(Color.theme.background)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    About()
}
