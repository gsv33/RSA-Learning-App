//
//  TestAnimations.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/19/22.
//  File to be used to test animations in SwiftUI

import SwiftUI

var i = 0

struct TestAnimations: View {
    @State var showDetail = false
    
    var body: some View {
        VStack {
            Button("Test") {
                showDetail.toggle()
            }
            
            VStack {
                if showDetail {
                    Text("Appeared")
                }
            }.animation(.easeInOut(duration: 2), value: showDetail)
        }
    }
}

struct TestAnimations_Previews: PreviewProvider {
    static var previews: some View {
        TestAnimations()
    }
}
