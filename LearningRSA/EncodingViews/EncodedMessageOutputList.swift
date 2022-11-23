//
//  EncodedMessageOutputList.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/20/22.
//
//  Displays the modular exponentiation used to create the encoded message

import SwiftUI

struct EncodedMessageOutputList: View {
    @EnvironmentObject var rsa: RSA
    @Binding var animationFinished: Bool
    
    @State private var currNum = 0
    @State private var currInput = "X"
    @State private var currOutput = "Y"

    @State var showEncodedNums: [Bool] = []
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // move to the next equation in the encoding 
    func updateEquation() {
        let listCount = rsa.inputMessageNumList.count
        
        if currNum < listCount {
            currInput = String(rsa.inputMessageNumList[currNum].value)
            currOutput = String(rsa.encodedMessageList[currNum].value)
            showEncodedNums[currNum] = true
            
            currNum += 1
        }
        else {
            // Note: updating the binding here will cause the view to be reloaded
            animationFinished = true
            timer.upstream.connect().cancel()
        }
    }
    
    var body: some View {
        VStack {
            
            // first row of equation (x^k mod m)
            HStack(spacing: 0) {
                Text(currInput).font(.system(size: 24))
                Grid {
                    GridRow {
                        Text("k")
                    }
                    GridRow {Text("")}
                    GridRow {Text("")}
                }
                
                Text("(mod m)").font(.system(size: 24))
                    .padding([.leading],10)
            }
            
            // second row of equation (=)
            Text("=").font(.system(size: 30)).padding([.top], -25)
            
            // third row of equation (y)
            Text(currOutput).font(.system(size: 24))

            // animated list of all the outputs combined
            HStack {
                ForEach(0..<showEncodedNums.count, id: \.self) {i in
                    if showEncodedNums[i] {
                        let val = rsa.encodedMessageList[i].value
                        Text(String(val))
                    }
                }
            }
            .animation(.easeInOut.delay(1), value: currNum)
            .padding([.top], 20)
        }
        .onAppear {
            let encodedNumsCount = rsa.encodedMessageList.count
            showEncodedNums = Array(repeating: false, count: encodedNumsCount)
        }
        .onReceive(timer) { _ in
            updateEquation()
        }
    }
}

struct EncodedMessageOutputList_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @State static var animationFinished = false
    
    static var previews: some View {
        EncodedMessageOutputList(animationFinished: $animationFinished)
            .environmentObject(rsa)
    }
}
