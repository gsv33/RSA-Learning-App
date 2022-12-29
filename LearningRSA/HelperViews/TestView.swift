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
                NavigationToolbar(titleText: "Test Title")
            }.navigationBarBackButtonHidden()
        }
    }
}

struct LetterNumberTest: View {
    
//    var charToNumArr = CharacterConverter().charToNumArr
    
    var body: some View {
        ScrollView {
            
                    
//            Grid {
//                GridRow {
//                    ForEach(0 ..< 10) { i in
//                        Text(String(charToNumArr[i].char))
//                    }
//                }
//                Divider()
//                GridRow {
//                    ForEach(0 ..< 10) { i in
//                        Text(String(charToNumArr[i].number))
//                    }
//                }
//                Divider()
//                GridRow {
//                    ForEach(10 ..< 20) { i in
//                        Text(String(charToNumArr[i].char))
//                    }
//                }
//                Divider()
//                GridRow {
//                    ForEach(10 ..< 20) { i in
//                        Text(String(charToNumArr[i].number))
//                    }
//                }
//            }.padding()
        }
    }
}


struct VerticalTest: View {
    var charToNumArr = CharacterConverter.charToNumArray
    let columns = [GridItem(), GridItem(), GridItem()]

    let charColor = Color(red: 255 / 255, green: 215 / 255, blue: 135 / 255)
    let numColor = Color(red: 125 / 255, green: 255 / 255, blue: 255 / 255)
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0 ..< charToNumArr.count) { i in
                        
                        if charToNumArr[i].character == " " { // separate to show space bar as an image
                            Text(Image(systemName: "space"))
                                .foregroundColor(charColor) +
                            Text(" = ")
                                .font(.system(.headline, design: .rounded, weight: .semibold)) +
                            Text(charToNumArr[i].number)
                                .foregroundColor(numColor)
                        }
                        else {
                            Text(String(charToNumArr[i].character))
                                .foregroundColor(charColor) +
                            Text(" = ") +
                            Text(charToNumArr[i].number)
                                .foregroundColor(numColor)
                        }
                    }
                }
            }
            .foregroundColor(.white)
            .font(.system(.headline, design: .monospaced, weight: .semibold))
        }
    }
}


struct CustomView<Content: View>: View {
    var testView: Content
    
    var body: some View {
        VStack {
            Text("Test")
            
            testView
        }
    }
}

struct PaddingTest: View {
    var body: some View {
        VStack {
            Text("ABC")
            (Text("Test") + Text(" Test 2")).padding()

            Text("ABC")
            Group {
                Text("Test") + Text(" Test 2")
            }.padding()

        }
    }
}

struct TestView_Previews: PreviewProvider {
    
    static var previews: some View {
        PaddingTest()
    }
}
