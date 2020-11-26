//
//  ContentView.swift
//  BowWow
//
//  Created by Burri, Luke on 2020-11-26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    //show a new dog
                }, label: {
                    Text("More please")
                })
                
                Image("example")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Spacer()
            }
            .navigationTitle("bow WOW!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
