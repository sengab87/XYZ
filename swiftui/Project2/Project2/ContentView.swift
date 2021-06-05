//
//  ContentView.swift
//  Project2
//
//  Created by Ahmed Sengab on 6/1/21.
//

import SwiftUI
class ContentViewData: ObservableObject {
    @Published var counter : Int = 0
}
struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
