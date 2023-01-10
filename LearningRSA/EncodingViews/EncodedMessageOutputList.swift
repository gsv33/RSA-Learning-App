//
//  EncodedMessageOutputList.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/20/22.
//
//  Displays the modular exponentiation used to create the encoded message

import SwiftUI

struct EncodedMessageOutputList: View {
    var inputs: [Number]
    var outputs: [Number]
    var exponentSymbol: String = "E"
    var modulusSymbol: String = "M"
    
    var exponent: String
    var modulus: String
    
    @Binding var animationFinished: Bool
    @Binding var hideText: Bool
    
    @State private var currNum = 0
    @State private var currInput = "A"
    @State private var currOutput = "B"

    @State var showEncodedNums: [Bool] = []
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // move to the next equation in the encoding 
    func updateEquation() {
        let listCount = inputs.count
        
        if currNum < listCount {
            withAnimation {
                currInput = String(inputs[currNum].value)
                currOutput = String(outputs[currNum].value)
                showEncodedNums[currNum] = true
                
                currNum += 1
            }
        }
        else {
            // Note: updating the binding here will cause the view to be reloaded
            animationFinished = true
            timer.upstream.connect().cancel()
        }
    }
    
    var body: some View {
        VStack {
            
            if hideText == false {
                // first row of equation (x^k mod m)
                HStack(spacing: 0) {
                    Text(currInput)
                        .font(.system(size: 24))
                        .foregroundColor(Colors.inputColor)
                    Grid {
                        GridRow {
                            Text(currNum == 0 ? exponentSymbol : exponent)
                                .foregroundColor(Colors.lightBlue)
                        }
                        GridRow {Text("")}
                        GridRow {Text("")}
                    }
                    
                    Group {
                        Text("mod ") +
                        Text(currNum == 0 ? modulusSymbol : modulus)
                            .foregroundColor(Colors.lightBlue)
                    }
                    .font(.system(size: 24))
                    .padding([.leading],10)
                }
                
                // second row of equation (=)
                Text("=").font(.system(size: 30)).padding([.top], -25)
                
                // third row of equation (y)
                Text(currOutput)
                    .font(.system(size: 24))
                    .foregroundColor(Colors.outputColor)
            }
            
            // animated list of all the outputs combined
            Text("Output Numbers:").padding(.top, 10)
            HStack {
                ForEach(0..<showEncodedNums.count, id: \.self) {i in
                    if showEncodedNums[i] {
                        let val = outputs[i].value
                        Text(val)
                    }
                }
            }
            .animation(.easeInOut.delay(1), value: currNum)
            .foregroundColor(Colors.outputColor)
        }
        .onAppear {
            let encodedNumsCount = outputs.count
            showEncodedNums = Array(repeating: false, count: encodedNumsCount)
//            updateEquation()
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
        EncodedMessageOutputList(
            inputs: [Number(value: "A")],
            outputs: [Number(value: "B")],
            exponent: "E",
            modulus: "M",
            animationFinished: $animationFinished,
            hideText: .constant(false)
        )
    }
}
