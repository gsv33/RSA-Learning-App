//
//  Styles.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/2/22.
//

import SwiftUI

/*
 Creates a bordered text field that looks better when disabled
 against a black background than the default settings
 */
struct BorderedTextField: ViewModifier {
    var disable: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.system(.title))
            .padding([.top, .bottom], 3)
            .padding(.leading, 5)
            .padding(.trailing, 20)
            .background(
                RoundedRectangle(cornerRadius: 3)
                    .fill(.white)
                )
            .foregroundColor(.black)
            .fixedSize()
            .disabled(disable)
            .opacity(disable ? 0.6 : 1.0)        
    }
}

struct MonospacedTitleText: ViewModifier {
    var textStyle: Font.TextStyle
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(textStyle, design: .monospaced, weight: .semibold))
    }
}

struct MonospacedBodyText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(.headline, design: .monospaced, weight: .semibold))
            .foregroundColor(.white)
    }
}

struct MonospacedInfoText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(.headline, design: .monospaced, weight: .semibold))
            .foregroundColor(Colors.textColor)
    }
}

struct PurpleButtonStyle: ViewModifier {
    var textStyle: Font.TextStyle
    
    func body(content: Content) -> some View {
        content
            .font(.system(textStyle, design: .monospaced))
            .foregroundColor(.white)
            .tint(Color(red: 111 / 255, green: 26 / 255, blue: 182 / 255))
            .buttonStyle(.borderedProminent)
    }
}

struct NavBarButtonStyle: ViewModifier {
    var textStyle: Font.TextStyle
    
    func body(content: Content) -> some View {
        content
            .font(.system(textStyle, design: .monospaced))
            .foregroundColor(.white)
            .tint(Color(red: 57 / 255, green: 81 / 255, blue: 68 / 255))
            .buttonStyle(.borderedProminent)
    }
}

extension View {
    func monospacedTitleText(textStyle: Font.TextStyle = .title3) -> some View {
        modifier(MonospacedTitleText(textStyle: textStyle))
    }
    
    func monospacedBodyText() -> some View {
        modifier(MonospacedBodyText())
    }
    
    func monospacedInfoText() -> some View {
        modifier(MonospacedInfoText())
    }
    
    func purpleButtonStyle(textStyle: Font.TextStyle = .headline) -> some View {
        modifier(PurpleButtonStyle(textStyle: textStyle))
    }
    
    func navBarButtonStyle(textStyle: Font.TextStyle = .headline) -> some View {
        modifier(NavBarButtonStyle(textStyle: textStyle))
    }
    
    func borderedTextField(disable: Bool) -> some View {
        modifier(BorderedTextField(disable: disable))
    }
}

struct GenerateRandomPrimesButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding([.top, .bottom], 8)
            .padding([.leading, .trailing], 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.green)
            )
            .font(.system(.headline, design: .monospaced))
            .opacity(isEnabled ? 1.0 : 0.5)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}


// White border around button
struct MenuButtonStyle: ButtonStyle {
    
    var textStyle: Font.TextStyle = .headline
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(textStyle, design: .monospaced))
            .foregroundColor(.white)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 2)
            )
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
    }
}

    

// White border around button
struct BackButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline, design: .monospaced))
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white, lineWidth: 2)
            )
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeOut(duration: 0.3), value: configuration.isPressed)
    }
}

// Button with white text on dark blue background
// And flashing white border around button
struct DecodeButtonStyle: ButtonStyle {
    @State var strokeLineWidth = 2.0
    var buttonAnimation = Animation.easeInOut(duration: 1.5)
    
    @Binding var startAnimation: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline, design: .monospaced))
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 7, leading: 50, bottom: 7, trailing: 50))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Colors.darkBlue)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white, lineWidth: strokeLineWidth)
            )
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeOut(duration: 0.3), value: configuration.isPressed)

            // Repeating animation won't stop unless it's replaced with an animation that doesn't repeat
            // See https://stackoverflow.com/questions/59133826/swiftui-stop-an-animation-that-repeats-forever
            .animation(startAnimation ? buttonAnimation.repeatForever() : buttonAnimation,
                       value: strokeLineWidth)
            .onChange(of: startAnimation) {_ in
                strokeLineWidth = startAnimation ? 0.0 : 2.0
            }
    }
}





struct ChecklistToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: configuration.isOn
                        ? "checkmark.square.fill"
                        : "square")
                configuration.label
            }
        }
        .tint(.primary)
        .buttonStyle(.borderless)
    }
}


struct UnicodeCharacters {
    
    static let superscriptD = "\u{1D30}"
    static let superscriptE = "\u{1D31}"
    
    static let superscriptNums = [0: "\u{2070}",
                                  1: "\u{00B9}",
                                  2: "\u{00B2}",
                                  3: "\u{00B3}",
                                  4: "\u{2074}",
                                  5: "\u{2075}",
                                  6: "\u{2076}",
                                  7: "\u{2077}",
                                  8: "\u{2078}",
                                  9: "\u{2079}"]
}

// contains colors used in the app's views
struct Colors {
     
    static let backgroundColor = Color.black
    static let textColor = Color.green

    static let inputColor = Color(red: 255 / 255, green: 215 / 255, blue: 135 / 255)
    static let outputColor = Color(red: 125 / 255, green: 255 / 255, blue: 255 / 255)
    
    static let baseColor = Color.yellow
    static let expColor = Color.blue
    static let modColor = Color.red
    
    static let lightRed = Color(red: 235 / 255, green: 69 / 255, blue: 95 / 255)
    static let darkBlue = Color(red: 20 / 255, green: 38 / 255, blue: 71 / 255)
    static let lightBlueGreen = Color(red: 163 / 255, green: 199 / 255, blue: 214 / 255)
    static let lightPurple = Color(red: 229 / 255, green: 184 / 255, blue: 244 / 255)
    static let lightBlue = Color(red: 188 / 255, green: 206 / 255, blue: 248 / 255)
    
    static let magnesium = Color(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1))
}

struct GlobalVars {
    
    static let invalidSymbol = "multiply"
    static let validSymbol = "checkmark"
    static let maxDigitsInPrime = 4
    static let maxCharsInMessage = 100
    static let phi = "Φ"
    
    
}
