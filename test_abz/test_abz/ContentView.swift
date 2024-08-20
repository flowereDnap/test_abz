//
//  ContentView.swift
//  test_abz
//
//  Created by mac on 19.08.2024.
//

import SwiftUI

struct ContentView: View {
    let a = NWManager.shared.fetchUsers(completion: {_ in })
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
