//
//  PrimeTextFieldsView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/30/22.
//

import SwiftUI

struct PrimeTextFieldsView: View {
    @Binding var prime1: String
    @Binding var prime2: String
    
    @Binding var primeImage1: String
    @Binding var primeImage2: String
    
    var validSymbol: String = "checkmark"
    var invalidSymbol: String = "multiply"
    
    @Binding var allowEditPrimes: Bool
    var showUseDifferentPrimesCheckbox = true
    var showGenerateRandomPrimesButton = true
        
    var title = "Primes"
    var titleTextStyle = Font.TextStyle.title
    
    var body: some View {
        Text(title)
            .monospacedTitleText(textStyle: titleTextStyle)
            .padding([.bottom], 5)
        
        Grid {
            GridRow {
                Image(systemName: primeImage1)
                    .opacity(prime1.count == 0 ? 0.0 : 1.0)
                    .foregroundColor(primeImage1 == validSymbol ? Color.green : Color.red)
                    .bold()
                
                Image(systemName: primeImage2)
                    .opacity(prime2.count == 0 ? 0.0 : 1.0)
                    .foregroundColor(primeImage2 == validSymbol ? Color.green : Color.red)
                    .bold()
            }.padding([.bottom], 5)
            GridRow {
                TextField("Prime 1", text: $prime1)
                    .borderedTextField(disable: !allowEditPrimes)
                    .onChange(of: prime1) { _ in
                        let p1 = isPrime(p: prime1)
                        primeImage1 = p1 ? validSymbol : invalidSymbol
                    }
                
                TextField("Prime 2", text: $prime2)
                    .borderedTextField(disable: !allowEditPrimes)
                    .onChange(of: prime2) { _ in
                        let p2 = isPrime(p: prime2)
                        primeImage2 = p2 ? validSymbol : invalidSymbol
                    }
            }
        }
        
        if showUseDifferentPrimesCheckbox  {
            Toggle(isOn: $allowEditPrimes) {
                Text("Use different primes")
            }
            .padding(2)
            .toggleStyle(ChecklistToggleStyle())
        }
        
        if showGenerateRandomPrimesButton {
            Button("Generate random primes") {
                let p1 = generatePrimeNumber()
                var p2 = generatePrimeNumber()
                
                while p1 == p2 { // primes cannot match
                    p2 = generatePrimeNumber()
                }
                
                prime1 = String(p1)
                prime2 = String(p2)
                
                primeImage1 = validSymbol
                primeImage2 = validSymbol
            }
            .buttonStyle(GenerateRandomPrimesButtonStyle())
            .disabled(!allowEditPrimes)
            .padding([.bottom], 10)
        }


    }
}

// This view is only used for displaying the preview
struct PreviewView: View {
    @State var prime1 = "123"
    @State var prime2 = "5678"
    @State var primeImage1 = "multiply"
    @State var primeImage2 = "multiply"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
         
            VStack {
                PrimeTextFieldsView(
                    prime1: $prime1,
                    prime2: $prime2,
                    primeImage1: $primeImage1,
                    primeImage2: $primeImage2,
                    allowEditPrimes: .constant(true),
                    showUseDifferentPrimesCheckbox: false
                )
            }
            .foregroundColor(.white)
        }
    }
}

struct PrimeTextFieldsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
}
