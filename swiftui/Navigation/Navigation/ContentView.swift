//
//  ContentView.swift
//  Navigation
//
//  Created by Ahmed Sengab on 6/1/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, world!")
                Spacer()
            }
            .padding()
            navigationBarTitle("Home Screen")
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
