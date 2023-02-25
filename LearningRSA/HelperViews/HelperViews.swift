//
//  HelperViews.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/25/22.
//

import SwiftUI

// Displays the navigation toolbar used across the
// app's views
struct NavigationToolbar: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    @State private var showMenuSheet = false
    
    var currentView: ViewNames
    var titleText: String
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Back") {
                dismiss()
            }
            .purpleButtonStyle()
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Menu") {
                showMenuSheet = true
            }
            .sheet(isPresented: $showMenuSheet) { MenuView(currentView: currentView) }
            .purpleButtonStyle()
        }
        
        ToolbarItem(placement: .principal) {
            ViewThatFits {
                Text(titleText)
                    .monospacedTitleText(textStyle: .title3)
 
                Text(titleText)
                    .monospacedTitleText(textStyle: .headline)
            }
        }
    }
}


// This is the "More Info" button that provides more detailed
// explanations across the app's views
struct MoreInfoButton<Content: View>: View {
    @Binding var showInfoSheet: Bool
    var InfoView: Content // the info view to be displayed
    
    var body: some View {
        Button(action: {
            showInfoSheet = true
        }) {
            Label("More Info", systemImage: "info.square")
        }
        .sheet(isPresented: $showInfoSheet) { InfoView }
        .monospacedInfoText()
    }
}

// Shows the entire character to number mapping used as a sheet
struct MappingView: View {
    @Environment(\.dismiss) var dismiss
    
    var charToNumArr = CharacterConverter.charToNumArray
    let columns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()

            VStack {
                ScrollView {
                    Text("Character to Number Mapping")
                        .monospacedTitleText().padding(5)
                    
                    LazyVGrid(columns: columns) {
                        ForEach(0 ..< charToNumArr.count) { i in
                            
                            if charToNumArr[i].character == " " { // separate to show space bar as an image
                                Text(Image(systemName: "space"))
                                    .foregroundColor(Colors.inputColor) +
                                Text(" = ")
                                    .font(.system(.headline, design: .rounded, weight: .semibold)) +
                                Text(charToNumArr[i].number)
                                    .foregroundColor(Colors.outputColor)
                            }
                            else {
                                Text(String(charToNumArr[i].character))
                                    .foregroundColor(Colors.inputColor) +
                                Text(" = ") +
                                Text(charToNumArr[i].number)
                                    .foregroundColor(Colors.outputColor)
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .font(.system(.headline, design: .monospaced, weight: .semibold))

                
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
        }
    }
}

// Displays text in a scroll view with a border
// around it
struct TextInScrollView: View {
    var message: String
    var textSize = Font.TextStyle.headline
    var maxHeight: CGFloat = 100
    var minHeight: CGFloat = 75
    
    var body: some View {
        ScrollView() {
            Text(message)
                .foregroundColor(.black)
                .padding()
                .font(.system(textSize, design: .monospaced, weight: .semibold))
        }
        .frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: maxHeight)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
        )
    }
}

// Text in scroll view with a black background
struct AlternateTextInScrollView: View {
    var message: String
    var textSize = Font.TextStyle.headline
    var textColor = Colors.inputColor
    var maxHeight: CGFloat = 100
    var minHeight: CGFloat = 75
    
    var body: some View {
        ScrollView() {
            Text(message)
                .foregroundColor(textColor)
                .font(.system(textSize, design: .monospaced))
                .padding()
        }
        .frame(maxWidth: .infinity, minHeight: minHeight, maxHeight: maxHeight)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 3)
        )
    }
}



struct EncodeEquation: View {
    var body: some View {
        Text("X\(UnicodeCharacters.superscriptE) mod M")
            .font(.system(.title))
            .foregroundColor(Colors.outputColor)
    }
}

struct DecodeEquation: View {
    var body: some View {
        Text("Y\(UnicodeCharacters.superscriptD) mod M")
            .font(.system(.title))
            .foregroundColor(Colors.outputColor)
    }
}

// displays the encryption or decryption key
struct DisplayKeyView: View {
    var exponent: Int
    var product: Int
    var textStyle = Font.TextStyle.title2
    var textColor = Colors.outputColor

    var body: some View {
        (Text(String(exponent)) +
        Text("-")
            .foregroundColor(.white) +
        Text(String(product)))
            .font(.system(textStyle, design: .monospaced, weight: .semibold))
            .foregroundColor(textColor)
    }
}

struct ExploreRSAHelpView: View {
    
    let title = "Explore RSA"
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigationController: NavigationController
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            GeometryReader {geometry in
                ScrollView {
                    VStack {
                        Text(title)
                            .monospacedTitleText()
                            .padding()
                        
                        Text("In this section, you can experiment with encoding and decoding a message using the RSA algorithm.").padding()
                        
                        Text("On the encode screen, enter a message, choose two prime numbers to secure your message, and click the \"Encode Message\" button to see your encoded message and correspondng encryption key.")
                            .padding()
                        
                        Text("On the decode screen, you can decode the message that you just encoded. Use the same prime numbers you used for the encoding to get your original input message back, or enter new prime numbers to see how that affects your decoded message.")
                            .padding()
                        
                        Button("Back to Welcome Screen") {
                            
                            // can be accessed from either the Tutorial NavigationLink or
                            // the Explore NavigationLink, so need to check both
                            navigationController.popToRootFromTutorial()
                            navigationController.popToRootFromExploreRSA()
                        }
                        .purpleButtonStyle()
                        .padding()
                        
                        Button("Dismiss") {dismiss()}
                            .purpleButtonStyle()
                        
                    }
                    .monospacedBodyText()
                    .frame(minHeight: geometry.size.height)
                }
            }
        }
    }
}

struct HelperViews_Previews: PreviewProvider {
    @StateObject static var navigationController = NavigationController()
    
    static var previews: some View {
//        ExploreRSAHelpView()
//            .environmentObject(navigationController)
        
        MappingView()
    }
}
