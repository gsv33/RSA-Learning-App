//
//  TestView.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/2/22.
//

import SwiftUI


struct TestView2: View {
    @State private var animationAmount = 1.0

    var body: some View {
        Button("Tap Me") {
//            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(.blue)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeInOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animationAmount
                )
        )
        .onAppear {
            animationAmount = 2
        }
    }
}



struct TestView: View {
    @State var startAnimation = false
    
    var body: some View {
        VStack {
            Button("Click") {
                startAnimation.toggle()
                print(startAnimation)
            }
            
            ZStack {
                Color.black.ignoresSafeArea()
                DecodeButtonView(startAnimation: $startAnimation)
            }
        }
    }

}

struct TextEditingView: View {
    @State private var fullText: String = "This is some editable text... type something"


    var body: some View {
        TextEditor(text: $fullText)
            .font(.system(.title2, design: .monospaced, weight: .medium))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2)
            )
            .padding()

    }
}

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
            backgroundColor.ignoresSafeArea()
            VStack {
                Text("This is a test")
            }.toolbar {
                NavigationToolbar(titleText: "Test Title")
            }.navigationBarBackButtonHidden()
        }
    }
}

struct LetterNumberTest: View {
    
    var charToNumArr = CharacterConverter().charToNumArr
    
    var body: some View {
        ScrollView {
            
            
            
            Grid {
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
            }.padding()
        }
    }
}

struct GridItemDemo: View {
    let rows = [
        GridItem(.fixed(30), spacing: 1),
        GridItem(.fixed(60), spacing: 10),
        GridItem(.fixed(90), spacing: 20),
        GridItem(.fixed(10), spacing: 50)
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 5) {
                ForEach(0...300, id: \.self) { _ in
                    Color.red.frame(width: 30)
                    Divider()
                    Color.green.frame(width: 30)
                    Color.blue.frame(width: 30)
                    Divider()
                    Color.yellow.frame(width: 30)
                }
            }
        }
    }
}

struct VerticalTest: View {
    var charToNumArr = CharacterConverter().charToNumArr
    let columns = [GridItem()]

    var body: some View {
         ScrollView {
             LazyVGrid(columns: columns) {
                 ForEach(0 ..< charToNumArr.count) { i in
                     Text(String(charToNumArr[i].char)) +
                     Text("🟰") +
                     Text(String(charToNumArr[i].number))
                 }
             }
         }
    }

    private func emoji(_ value: Int) -> String {
        guard let scalar = UnicodeScalar(value) else { return "?" }
        return String(Character(scalar))
    }
}

struct TestView_Previews: PreviewProvider {
    
    static var previews: some View {
        VerticalTest()
    }
}
