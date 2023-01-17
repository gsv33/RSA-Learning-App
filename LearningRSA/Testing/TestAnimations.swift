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

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}

struct SlideAnimation: View {
    @State private var showDetails = false

    var body: some View {
        VStack {
            Button("Press to show details") {
                withAnimation {
                    showDetails.toggle()
                }
            }.padding()

            if showDetails {
                // Moves in from the bottom
                Text("Details go here.")
                    .transition(.moveAndFade)
//
//                // Moves in from leading out, out to trailing edge.
//                Text("Details go here.")
//                    .transition(.slide)
//
//                // Starts small and grows to full size.
//                Text("Details go here.")
//                    .transition(.scale)
            }
        }
    }
}

struct TimerAnimation: View {
    @State var elapsedTime = 0
    @State var opacity = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            
            Text("\(elapsedTime)")
                .onReceive(timer) { _ in
                    elapsedTime += 1
                    
                    if elapsedTime == 3 {
                        opacity = 1.0
                    }
                }
                .padding()
            
            Text("Details go here.")
                .opacity(opacity)
                .animation(.easeIn, value: opacity)
        }
    }
}

struct TestAnimations_Previews: PreviewProvider {
    static var previews: some View {
        TimerAnimation()
    }
}
