//
//  TestView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/2/22.
//

import SwiftUI


struct NavTest2: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Space")
            Divider()
            Spacer()
            Text("test Test Test test test")
            Spacer()
            
            NavigationLink(destination: Text("Test")) {
                Text("Button 2")
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Test") {
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Title abc")
    }
}

struct NavTest: View {
    var body: some View {
        NavigationStack {
            NavigationLink(destination: NavTest2()) {
                Text("Button 2")
            }
            .navigationTitle("Welcome")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("About") {
                        print("About tapped!")
                    }

                    Button("Help") {
                        print("Help tapped!")
                    }
                }
            }
        }
    }
}

struct NavStackTest: View {
    @State private var presentedNumbers = [Int]()

    var body: some View {
        NavigationStack(path: $presentedNumbers) {
            List(1..<50) { i in
                NavigationLink(value: i) {
                    Label("Row \(i)", systemImage: "\(i).circle")
                }
            }
            .navigationDestination(for: Int.self) { i in
                VStack {
                    Text("Detail \(i)")

                    Button("Go to Next") {
                        presentedNumbers.append(i + 1)
                    }
                }
            }
            .navigationTitle("Navigation")
        }
    }
}

struct NavViewTest: View {
    
    @State private var isShowingDetailView = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("Second View"), isActive: $isShowingDetailView) { }

                Button("Tap to show detail") {
                    isShowingDetailView = true
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Test").foregroundColor(.red)
                }
            }
        }
    }
}

struct PopoverTest: View {
    @State private var showingPopover = false

    var body: some View {
        Button("Show Menu") {
            showingPopover = true
        }
        .popover(isPresented: $showingPopover) {
            Text("Your content here")
                .font(.headline)
                .padding()
        }
    }
}

struct NavMenuViewTest: View {
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            VStack {
                Text("This is a test")
            }.toolbar {
                NavigationToolbar(currentView: .conclusionView, titleText: "Test Title")
            }.navigationBarBackButtonHidden()
        }
    }
}


// Tests all the RSA functions
//            print("Input String is: \(rsa.inputMessageEng)")
//            rsa.stringToNumberConversion()
//            print("Input Number is: \(rsa.inputMessageNum)")
//            rsa.computeProductOfPrimes()
//            rsa.splitInputNumberByDigits()
//            for i in rsa.inputMessageNumList {
//                print("Split digits are: \(i.value)")
//            }
//            try! rsa.computeEncryptionKeyE()
//            print("K: \(rsa.encryptionKeyE)")
//            print("P1: \(rsa.prime1), P2: \(rsa.prime2), M: \(rsa.productOfPrimes)")
//            rsa.encodeMessage()
//            for i in rsa.encodedMessageNumList {
//                print("Encoded message is: \(i.value)")
//            }
//            print("Encoded message str: \(rsa.encodedMessageNum)")
//
//            rsa.computeDecryptionKeys()
//            print("Real Inv Key: \(rsa.realDecryptionKeyD)")
//            print("Fake Inv Key: \(rsa.fakeDecryptionKeyD)")
//
//            rsa.decodeRealAndFakeMessages()
//            for i in rsa.realDecodedMessageNumList {
//                print("Real decoded message: \(i.value)")
//            }
//            print("Real decoded message: \(rsa.realDecodedMessageNum)")
//
//            print("")
//            for i in rsa.fakeDecodedMessageNumList {
//                print("Fake decoded message: \(i.value)")
//            }
//            print("Fake decoded message: \(rsa.fakeDecodedMessageNum)")
//
//            rsa.convertDecodedMessagesToEnglish()
//            print("Fake english: \(rsa.fakeDecodedMessageEng)")
//            print("Real english: \(rsa.realDecodedMessageEng)")
//
//            print("Done.")
//
            // Looks good so far!

class ObjTest: ObservableObject {
    @Published var popToRoot = false
    @Published var popToRoot2 = false
}

struct PopToRootView1: View {
    @EnvironmentObject var menuControl: ObjTest

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: PopToRootView2(),
                    isActive: $menuControl.popToRoot
                ) {
                    Text("Hello, World!")
                }
                .isDetailLink(false)
                .navigationBarTitle("Root")
                .padding()
                
                NavigationLink(
                    destination: Text(menuControl.popToRoot ? "True" : "False"),
                    isActive: $menuControl.popToRoot2
                ) {
                    Text("Button 2")
                }
                .isDetailLink(false)
                .navigationBarTitle("Root")
                
            }
        }
    }
}

struct PopToRootView2: View {
    @EnvironmentObject var menuControl: ObjTest
    
    var body: some View {
        VStack {
            NavigationLink(destination: PopToRootView3()) {
                Text("Hello, World #2!")
            }
            .isDetailLink(false)
            .navigationBarTitle("Two")
            
            Text(menuControl.popToRoot ? "True" : "False")
        }
    }
}

struct PopToRootView3: View {
    @EnvironmentObject var menuControl: ObjTest

    var body: some View {
        VStack {
            Text("Hello, World #3!")
            Button("Pop to Root") {
                menuControl.popToRoot = false
            }
        }.navigationBarTitle("Three")
    }
}


struct ViewThatFitsTest: View {
    let terms = String(repeating: "abcde ", count: 100)

    var body: some View {
        ViewThatFits {
            Text(terms)

            ScrollView {
                Text(terms)
            }
        }
    }
}

struct ViewThatFitsTest2: View {

    var body: some View {
        ViewThatFits {
            HStack {
                Text("The")
                Text("in ")
                Text("falls mainly")
                Text("on the Spaniards")
            }

//            VStack {
//                Text("The rain")
//                Text("in Spain")
//                Text("falls mainly")
//                Text("on the Spaniards")
//            }
        }
        .font(.title)
    }
}

struct NestedScrollViewTest: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Top view")

                DropdownSelector()

                Text("Bottom view")
            }
        }
    }
}

struct DropdownSelector: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0 ..< 10) { i in
                    Text("Item: \(i)")
                }
            }
        }.frame(height: 100)
    }
}

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
