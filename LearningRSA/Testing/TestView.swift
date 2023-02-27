//
//  TestView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/2/22.
//
//  Used for testing different SwiftUI views and features

import SwiftUI

struct ButtonTest: View {
    @State var show = false
    
    var body: some View {
        VStack {
            Button("Test") {
                withAnimation {
                    show.toggle()
                }
            }
            
            if show {
                Text("HELLO!").padding()
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    
    static var previews: some View {
        ButtonTest()
    }
}
