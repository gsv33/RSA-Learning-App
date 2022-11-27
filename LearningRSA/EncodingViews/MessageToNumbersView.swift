//
//  MessageToNumbersView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/30/22.
//

import SwiftUI


struct MessageToNumbersView: View {
    @EnvironmentObject var rsa: RSA
    @EnvironmentObject var vc: ViewCoordinator
    
    var charToNumArr = CharacterConverter().charToNumArr
    
    var body: some View {
        
        VStack{
            Text("Next we'll take your message and convert it to numbers. This isn't part of the algorithm, its just easier to work with numbers than letters.")

            Group {
                Divider()
                Text("Here's what you entered:")
                Text(rsa.inputMessageEng)
                Divider()
            }

            Grid {
                Text("This is the mapping we use:")
                
                Group {
                    GridRow {
                        ForEach(0 ..< 10) { i in
                            Text(String(charToNumArr[i].char))
                        }
                    }
                    Divider()
                    GridRow {
                        ForEach(0 ..< 10) { i in
                            Text(String(charToNumArr[i].number))
                        }
                    }
                    Divider()
                    GridRow {
                        ForEach(10 ..< 20) { i in
                            Text(String(charToNumArr[i].char))
                        }
                    }
                    Divider()
                    GridRow {
                        ForEach(10 ..< 20) { i in
                            Text(String(charToNumArr[i].number))
                        }
                    }
                }
                Group {
                    Divider()
                    GridRow {
                        ForEach(20 ..< 26) { i in
                            Text(String(charToNumArr[i].char))
                        }
                    }
                    Divider()
                    GridRow {
                        ForEach(20 ..< 26) { i in
                            Text(String(charToNumArr[i].number))
                        }
                    }
                }
            }.padding()
            
            Group {
                Divider()
                Text("This is the output:")
                Text(rsa.inputMessageNum)
                Divider()
            }

            Button("Enter primes to encode") {
                vc.currentView = .enterEncodePrimesView
            }            
        }
    }
}

struct MessageToNumbersView_Previews: PreviewProvider {
    @StateObject static var rsa = RSA()
    @StateObject static var vc = ViewCoordinator()

    static var previews: some View {
        MessageToNumbersView()
            .environmentObject(rsa)
            .environmentObject(vc)
    }
}
