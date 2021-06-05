//
//  ContentView.swift
//  Project3
//
//  Created by Ahmed Sengab on 6/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive: Bool = false
    var body: some View {
        Text("Hello, world!")
            .padding()
            .background(isActive ? Color.red : Color.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
