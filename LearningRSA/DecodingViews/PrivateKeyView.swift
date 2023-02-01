//
//  PrivateKeyView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 1/1/23.
//
//  Shows how the decryption key is created
//  NOTE: This file has gotten very messy after adding the animations,
//  needs to be re-organized

import SwiftUI

struct PrivateKeyView4: View {
    @EnvironmentObject var rsa: RSA
    @State private var showInfoSheet = false
    @Binding var showNextView: Bool
    
    @State var elapsedTime = 0
    @State var textOpacity1 = 0.0
    @State var textOpacity2 = 0.0

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // for animations

    func timerUpdate() {
        elapsedTime += 1

        if elapsedTime == 2 {
            textOpacity1 = 1.0
        } else if elapsedTime == 6 {
            textOpacity2 = 1.0
        }
    }
    
    var body: some View {
        let M = rsa.productOfPrimes
        let DFake = rsa.fakeDecryptionKeyD
        
        Group {
            Divider()
                .frame(height: 1)
                .overlay(.white)
            
            Text("Remember that the decryption key above is for the actual prime numbers you used.")
                .padding()
            
            Text("For the fake primes, we do the exact same thing, and get a new decryption key of:")
                .padding([.leading, .trailing, .bottom])
        }
        .onReceive(timer) { _ in
            timerUpdate()
        }
        .opacity(textOpacity1)
        .animation(.easeIn(duration: 1.0), value: textOpacity1)

        Group {
            Text("Fake Decryption Key")
                .monospacedTitleText(textStyle: .title3)
            
            DisplayKeyView(exponent: DFake, product: M, textColor: Colors.lightRed)
            
            MoreInfoButton(showInfoSheet: $showInfoSheet, InfoView: PrivateKeyInfoView())
                .padding()
            
            Button("Next") {
                showNextView = true
            }
            .buttonStyle(MenuButtonStyle())
            .padding()
        }
        .opacity(textOpacity2)
        .animation(.easeIn(duration: 1.0), value: textOpacity2)

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
    @Binding var viewSet: Int
    
    @State var elapsedTime = 0
    @State var textOpacity1 = 0.0
    @State var textOpacity2 = 0.0
    @State var textOpacity3 = 0.0

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // for animations

    func timerUpdate() {
        elapsedTime += 1

        if elapsedTime == 3 {
            textOpacity2 = 1.0
        } else if elapsedTime == 6 {
            textOpacity3 = 1.0
        }
    }
    
    var body: some View {
        let M = String(rsa.productOfPrimes)
        let E = String(rsa.encryptionKeyE)
        let D = String(rsa.realDecryptionKeyD)
        let phi = String(rsa.encodePhi)
               
        if viewSet < 2 {
            Group {
                Text("Now we solve this equation for D ")
                    .padding()
                
                HelperEquationView(E: E, phi: phi)
                    .padding(.bottom)
            }
            .onReceive(timer) { _ in
                timerUpdate()
            }
            .onAppear { textOpacity1 = 1.0 }
            .opacity(textOpacity1)
            .animation(.easeIn(duration: 1.0), value: textOpacity1)
            
            
            Group {
                Text("We get").padding(.bottom, 3)
                Group {
                    Text("D = ") + Text("\(D)").foregroundColor(Colors.outputColor)
                }
            }
            .opacity(textOpacity2)
            .animation(.easeIn(duration: 1.0), value: textOpacity2)
        }
            
        Group {
            if viewSet < 2 {
                Text("Putting it all together, your decryption key is")
                    .padding()
            }
            else {
                Text("Real Decryption Key")
                    .monospacedTitleText(textStyle: .title3)
                    .transition(.opacity)
                    .padding(.top)
            }
            
            DisplayKeyView(exponent: rsa.realDecryptionKeyD, product: rsa.productOfPrimes)
            
            if viewSet < 2 {
                Button("Next") {
                    withAnimation {
                        viewSet += 1
                    }
                }
                .buttonStyle(MenuButtonStyle())
                .padding()
            }
        }
        .opacity(textOpacity3)
        .animation(.easeIn(duration: 1.0), value: textOpacity3)

    }
}

struct PrivateKeyView2: View {
    @EnvironmentObject var rsa: RSA
    @Binding var viewSet: Int
    
    @State var elapsedTime = 0
    @State var textOpacity1 = 0.0
    @State var textOpacity2 = 0.0
    @State var textOpacity3 = 0.0
    @State var textOpacity4 = 0.0
    @State var textOpacity5 = 0.0

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect() // for animations

    func timerUpdate() {
        elapsedTime += 1

        if elapsedTime == 5 {
            textOpacity2 = 1.0
        } else if elapsedTime == 10 {
            textOpacity3 = 1.0
        } else if elapsedTime == 15 {
            textOpacity4 = 1.0
        }
    }
    
    var body: some View {
        let prime1 = String(rsa.prime1)
        let prime2 = String(rsa.prime2)
        let M = String(rsa.productOfPrimes)
        let E = String(rsa.encryptionKeyE)
        let phi = String(rsa.encodePhi)
        
        if viewSet < 2 {
            VStack {
                Group {
                    if viewSet == 0 {
                        Text("M is taken from the encryption key, so:")
                            .padding(.top)
                    }
                    
                    Group {
                        Text("M = ") + Text("\(M)").foregroundColor(Colors.outputColor)
                    }
                    .padding([.top, .bottom])
                }
                .onAppear { textOpacity1 = 1.0 }
                .opacity(textOpacity1)
                .animation(.easeIn(duration: 1.0), value: textOpacity1)
                
                Group {
                    if viewSet == 0 {
                        Text("D is calculated by solving the equation:").padding(.bottom)
                    }
                    
                    Text("E x D - Φ x K = 1")
                        .padding(.bottom)
                        .foregroundColor(Colors.inputColor)
                }
                .opacity(textOpacity2)
                .animation(.easeIn(duration: 1.0), value: textOpacity2)
                
                Group {
                    if viewSet == 0 {
                        Text("E is taken from the encryption key, so:").padding(.bottom,3)
                    }
                    Group {
                        Text("E = ") + Text("\(E)").foregroundColor(Colors.outputColor)
                    }
                    .padding(.bottom)
                }
                .opacity(textOpacity3)
                .animation(.easeIn(duration: 1.0), value: textOpacity3)
                
                Group {
                    if viewSet == 0 {
                        Group{
                            Text("Given your two prime numbers, P and Q, Φ is computed the same as before, ") +
                            Text("Φ = (P - 1) x (Q - 1)")
                        }
                        .padding([.trailing, .leading, .bottom])
                    }
                    Group {
                        if viewSet == 0 {
                            Text("Φ = ") +
                            Text("(\(prime1) - 1)").foregroundColor(Colors.inputColor) +
                            Text(" x ") +
                            Text("(\(prime2) - 1)").foregroundColor(Colors.inputColor)
                        }
                        Text("Φ = ") + Text("\(phi)").foregroundColor(Colors.outputColor)
                    }
                    .padding(3)
                    
                    if viewSet == 0 {
                        Button("Next") {
                            withAnimation {
                                viewSet += 1
                            }
                        }
                        .buttonStyle(MenuButtonStyle())
                        .padding()
                    }
                }
                .opacity(textOpacity4)
                .animation(.easeIn(duration: 1.0), value: textOpacity4)
            }
            .monospacedBodyText()
            .onReceive(timer) { _ in
                timerUpdate()
            }
        }
    }
}

struct PrivateKeyView: View {
    let titleText = "Decryption Key"
    @State var showNextView = false
    
    @State var viewSet1 = 1
    @State var viewSet2 = 0

    var body: some View{
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            NavigationLink(destination: DecodedMessageView(), isActive: $showNextView) {}
                .isDetailLink(false)
                .toolbar { NavigationToolbar(currentView: .privateKeyView, titleText: titleText) }
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
            
            GeometryReader {geometry in
                ScrollView {
                    VStack {
                        if viewSet1 == 1 {
                            Text("Just like how your encryption key was the two components E and M in the equation: ").padding()
                            
                            EncodeEquation()
                            
                            Text("Your decryption key is the two components D and M in the equation: ").padding()
                        }
                        
                        if viewSet2 == 0 {
                            DecodeEquation().padding(.top)
                        }
                        
                        if viewSet1 == 1 {
                            Text("Now we'll calculate the decryption key using both the real primes you used to encode your message, and the fake ones that simulate what a hacker might try.").padding()
                            
                            Button("Compute Real Decryption Key") {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    viewSet1 = 2
                                }
                            }
                            .buttonStyle(MenuButtonStyle())
                            .padding()
                        }
                        
                        if viewSet1 == 2 {
                            PrivateKeyView2(viewSet: $viewSet2)
                            
                            if viewSet2 >= 1 {
                                PrivateKeyView3(viewSet: $viewSet2)
                                
                                if viewSet2 == 2 {
                                    PrivateKeyView4(showNextView: $showNextView)
                                }
                            }
                        }
                    }
                    .frame(minHeight: geometry.size.height)
                    .monospacedBodyText()
                }
            }
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
