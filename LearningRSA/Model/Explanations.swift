//
//  Explanations.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/19/22.
//
//  Stores the detailed explanations for each step of the process

import SwiftUI

// Explainer on why this step is needed
struct MessageEncodingInfoView: View {
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                
                Text("Message to Numbers Conversion")
                    .monospacedTitleText()
                
                ScrollView {
                    Text("Before we can encrypt your message, we need to convert it to numbers.")
                        .padding()
                    
                    Text("The way RSA works is that first we transform your message to a sequence of numbers. Then, we apply a mathematical function to encrypt this sequence as a different sequence of numbers. So the first step is to convert the message to a bunch of numbers.")
                        .padding()
                    
                    Text("This doesn't need to be secure. The only thing that matters here is that the sender and receiver both know how the letters are converted into numbers").padding()
                    
                    Text("In this app, we just use a simple conversion scheme that covers the most commonly used English letters and punctuation (called the ASCII set). In real implementations, this would scale up to create encodings for other languages, symbols, emojis, etc (known as the Unicode set).").padding()
                    
                    Text("A → 00, B → 01, C → 02, ...")
                    Text("0 → 85, 1 → 86, 2 → 87, ...").padding(.bottom)
                    
                    Button("See the full mapping") {
                        //TODO:
                    }
                    
                }
            }
            .monospacedBodyText()
            
        }
    }
}

struct EnterPrimesInfoView: View {
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack{
                Text("Why Prime Numbers?")
                    .monospacedTitleText()
                    .padding()

                ScrollView {
                    
                    Text("Prime numbers are the building blocks of the RSA cryptosystem. This is because of the fundamental theorem of arithmetic, which says that every single positive integer has a unique prime factorization. These are the blue numbers below").padding()
                    
                    Text("100 = 2 x 2 x 5 x 5")
                    Text("561 = 3 x 11 x 17")
                    
                    Text("In practice, this means if we take two prime numbers and multiply them together, the product has only those two prime factors.").padding()
                    
                    Text("2627 = 37 x 71")
                    Text("9,049,387 = 2179 x 4153")
                    
                }
            }
            .monospacedBodyText()
        }
    }
}

struct GeneratePublicKeyInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
            }
        }
    }
}


struct SplitNumbersInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text("Splitting up the Message")
                    .monospacedTitleText()
                    .padding()

                ScrollView {
                    Text("Why can't we just use the original message? Why do we need to break it up into smaller pieces? The reason is.")
                }
                
            }.monospacedBodyText()
        }
    }
    
}

struct EncodeMessageInfoView: View {
    
    var body: some View {
        ZStack {
            
        }
    }
}

struct EnterDecodePrimesInfoView: View {
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
        }
    }
}

struct Explanations_Previews: PreviewProvider {
    static var previews: some View {
        SplitNumbersInfoView()
    }
}
