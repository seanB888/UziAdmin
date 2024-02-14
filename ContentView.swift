//
//  ContentView.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Home()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.black)
            .background(Color.theme.background)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
