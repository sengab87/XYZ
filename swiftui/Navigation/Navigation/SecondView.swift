//
//  SecondView.swift
//  Navigation
//
//  Created by Ahmed Sengab on 6/1/21.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        VStack(spacing: 5){
            
            Text("This is the content of the")
            Text("Second Screen")
            Spacer()
        }
        .padding()
        .navigationBarTitle("second screen")
    }
    
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SecondView()
        }
    }
}
