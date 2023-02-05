//
//  ContentView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/27/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var rsa = RSA()
    @StateObject var rsaExplore = RSAExplore()
    @StateObject var navigationController = NavigationController()
    
    var body: some View {
        NavigationView {
            WelcomeView()
        }
        .navigationViewStyle(.stack)
        .environmentObject(rsa) // must go outside navigation view
        .environmentObject(rsaExplore)
        .environmentObject(navigationController)
    }
}

struct ContentView_Previews: PreviewProvider {    
    static var previews: some View {
        ContentView()
    }
}
