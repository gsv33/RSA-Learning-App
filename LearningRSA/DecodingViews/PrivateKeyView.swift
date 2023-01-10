//
//  PrivateKeyView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 1/1/23.
//
//  Shows how the private key is created

import SwiftUI

struct PrivateKeyView4: View {
    @EnvironmentObject var rsa: RSA
    @State private var showInfoPopover = false
    
    var body: some View {
        let M = String(rsa.productOfPrimes)
        let DReal = String(rsa.realDecryptionKeyD)
        let DFake = String(rsa.fakeDecryptionKeyD)
        
        Text("Real Private Key")
            .monospacedTitleText(textStyle: .title3)
        
        Text("\(M)")
            .font(.system(.title2, weight: .semibold))
            .foregroundColor(Colors.outputColor) +
        Text("-") +
        Text("\(DReal)")
            .font(.system(.title2, weight: .semibold))
            .foregroundColor(Colors.outputColor)
        
        Divider()
            .frame(height: 1)
            .overlay(.white)
        
        Text("Remember that the private key above is for the actual prime numbers you used.")
            .padding()
        
        Text("For the fake primes, we do the exact same thing, and get a new private key of:")
            .padding([.leading, .trailing, .bottom])

        Text("Fake Private Key")
            .monospacedTitleText(textStyle: .title3)
        
        Text("\(M)")
            .font(.system(.title2, weight: .semibold))
            .foregroundColor(Colors.lightRed) +
        Text("-") +
        Text("\(DFake)")
            .font(.system(.title2, weight: .semibold))
            .foregroundColor(Colors.lightRed)
                
        MoreInfoButton(showInfoPopover: $showInfoPopover, InfoView: PrivateKeyInfoView())
            .padding()
    }
}

// added because otherwise the compiler was not
// able to type-check the expression
struct HelperEquationView: View {
    let E: String
    let phi: String
    
    var body: some View{
        Text("\(E)").foregroundColor(Colors.inputColor) +
        Text(" x ") +
        Text("D").foregroundColor(Colors.inputColor) +
        Text(" - ") +
        Text("\(phi)").foregroundColor(Colors.inputColor) +
        Text(" x ") +
        Text("K").foregroundColor(Colors.inputColor) +
        Text(" = 1")
    }
}

struct PrivateKeyView3: View {
    @EnvironmentObject var rsa: RSA
    @Binding var currentView: Int
    
    var body: some View {
        let M = String(rsa.productOfPrimes)
        let E = String(rsa.encryptionKeyE)
        let D = String(rsa.realDecryptionKeyD)
        let phi = String(rsa.encodePhi)
        
        DecodeEquation().padding()
        
        Group {
            Text("M = ") + Text("\(M)").foregroundColor(Colors.outputColor)
        }
        .font(.system(.title2))
        .padding(.bottom)

        Text("Now we solve this equation for D ")
            .padding(.bottom)

        HelperEquationView(E: E, phi: phi)
            .padding(.bottom)
        
        Text("We get").padding(.bottom, 3)
        Group {
            Text("D = ") + Text("\(D)").foregroundColor(Colors.outputColor)
        }
        .font(.system(.title2))

        Group {
            Text("Putting it all together, your private key is")
                .padding()

            Text("\(M)")
                .font(.system(.title2, weight: .semibold))
                .foregroundColor(Colors.outputColor) +
            Text("-") +
            Text("\(D)")
                .font(.system(.title2, weight: .semibold))
                .foregroundColor(Colors.outputColor)
        }
                
        Button("Next") {
            currentView += 1
        }
        .buttonStyle(MenuButtonStyle())
        .padding()

    }
}

struct PrivateKeyView2: View {
    @EnvironmentObject var rsa: RSA
    @Binding var currentView: Int
    
    var body: some View {
        let prime1 = String(rsa.prime1)
        let prime2 = String(rsa.prime2)
        let M = String(rsa.productOfPrimes)
        let E = String(rsa.encryptionKeyE)
//        let E = String(rsa.realDecryptionKeyD)
        let phi = String(rsa.encodePhi)
        
        VStack {
            DecodeEquation()
                .padding()
            
            Text("M is taken from the public key, so:")
                .padding([.leading, .trailing, .bottom])
            
            Group {
                Text("M = ") + Text("\(M)").foregroundColor(Colors.outputColor)
            }
            .font(.system(.title2))
            .padding(.bottom)
            
            Text("D is calculated by solving the equation:").padding(.bottom)
            Text("DE - ΦK = 1")
                .font(.system(.title2))
                .padding(.bottom)
            
            Group {
                Text("E is taken from the public key, so:").padding(.bottom,3)
                Group {
                    Text("E = ") + Text("\(E)").foregroundColor(Colors.outputColor)
                }
                .font(.system(.title2))
                .padding(.bottom)


                Group{
                    Text("Given your two prime numbers, p and q, Φ is computed the same as before, ") +
                    Text("Φ = (p - 1) x (q - 1)")
                }
                .padding([.trailing, .leading, .bottom])

                Group {
                    Text("Φ = ") +
                    Text("(\(prime1) - 1)").foregroundColor(Colors.inputColor) +
                    Text(" x ") +
                    Text("(\(prime2) - 1)").foregroundColor(Colors.inputColor)
                    
                    Text("Φ = ") + Text("\(phi)").foregroundColor(Colors.outputColor)
                }
                .padding(3)
                .font(.system(.title2))
            }
            
            Button("Next") {
                currentView += 1
            }
            .buttonStyle(MenuButtonStyle())
            .padding()
        }
    }
}

struct PrivateKeyView: View {
    let titleText = "Private Key"
    @State var showNextView = false
    
    @State var currentView = 1

    var body: some View{
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: DecodedMessageView(), isActive: $showNextView) {}
                .toolbar { NavigationToolbar(titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            VStack {
                if currentView == 1 {
                    Text("Just like how your public key was the two components E and M in the equation: ").padding()
                    
                    EncodeEquation()
                    
                    Text("Your private key is the two components D and M in the equation: ").padding()
                    
                    DecodeEquation()
                    
                    Text("Now we'll compute the private key using both the real primes you used to encode your message, and the fake ones that simulate what a hacker might try.").padding()
                    
                    Button("Compute Real Private Key") {
                        currentView = 2
                    }
                    .buttonStyle(MenuButtonStyle())
                }
                else if currentView == 2 {
                    PrivateKeyView2(currentView: $currentView)
                }
                else if currentView == 3 {
                    PrivateKeyView3(currentView: $currentView)
                }
                else {
                    PrivateKeyView4()
                    
                    Button("Next") {
                        showNextView = true
                    }
                    .buttonStyle(MenuButtonStyle())
                    .padding()
                }
            }.monospacedBodyText()
        }
    }
}

struct PrivateKeyView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()

    static var previews: some View {
        NavigationView {
            PrivateKeyView()
                .environmentObject(rsa)
        }
    }
}
