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
    @State var prime1Old: String = ""
    @State var prime2Old: String = ""
    
    @Binding var primeImage1: String
    @Binding var primeImage2: String
    
    let validSymbol = GlobalVars.validSymbol
    let invalidSymbol = GlobalVars.invalidSymbol
    
    @Binding var errorMessage: ErrorMessages
    @Binding var allowEditPrimes: Bool
    var showUseDifferentPrimesCheckbox = true
    var showGenerateRandomPrimesButton = true
        
    var title = "Primes"
    var titleTextStyle = Font.TextStyle.title
    
    func inputValidation(newVal: String, newPrime: inout String, oldPrime: inout String) {
        
        // necessary to make sure function isn't called again after changing newPrime
        if newPrime == oldPrime {
            return
        }
        
        if newVal == "" {
            errorMessage = .noError
            oldPrime = newVal
            return
        }
        
        // only allow numbers to be added
        guard let validInt = Int(newVal) else {
            errorMessage = .notNumber
            newPrime = oldPrime
            return
        }

        if validInt < 0 {
            errorMessage = .notNumber
            newPrime = oldPrime
            return
        }
        
        // primes must be under a certain length
        if newVal.count > GlobalVars.maxDigitsInPrime {
            errorMessage = .primesLimitReached
            newPrime = oldPrime
            return
        }
        
        errorMessage = .noError
        oldPrime = newVal
    }
    
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
                    .onChange(of: prime1) { newVal in
                        inputValidation(newVal: newVal, newPrime: &prime1, oldPrime: &prime1Old)
                        
                        let p1 = isPrime(p: prime1)
                        primeImage1 = p1 ? validSymbol : invalidSymbol
                    }
                
                TextField("Prime 2", text: $prime2)
                    .borderedTextField(disable: !allowEditPrimes)
                    .onChange(of: prime2) { newVal in
                        inputValidation(newVal: newVal, newPrime: &prime2, oldPrime: &prime2Old)
                        
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
    @State var errorMessage = ErrorMessages.noError
    
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
         
            VStack {
                ErrorMessageBar(errorMessage: errorMessage).padding()
                
                PrimeTextFieldsView(
                    prime1: $prime1,
                    prime2: $prime2,
                    primeImage1: $primeImage1,
                    primeImage2: $primeImage2,
                    errorMessage: $errorMessage,
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
