//
//  LearningRSAApp.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/27/22.
//

import SwiftUI

@main
struct LearningRSAApp: App {
    @StateObject var rsa = RSA()
    @StateObject var vc = ViewCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(rsa)
                .environmentObject(vc)
        }
    }
}
