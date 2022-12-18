//
//  Styles.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/2/22.
//

import SwiftUI

//// holds various style properties accessible to the app
//struct Styles {
//    
//    static let validSymbol = "checkmark"
//    static let invalidSymbol = "multiply"
//
//    
//}

/*
 Creates a bordered text field that looks better when disabled
 against a black background than the default settings
 */
struct BorderedTextField: ViewModifier {
    var disable: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.system(.title))
            .textFieldStyle(.roundedBorder)
            .foregroundColor(.black)
            .fixedSize()
            .disabled(disable)
            .opacity(disable ? 0.6 : 1.0)
    }
}

extension TextField {
    func borderedTextField(disable: Bool) -> some View {
        modifier(BorderedTextField(disable: disable))
    }
}

struct MonospacedTitleText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(.title3, design: .monospaced, weight: .semibold))
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
            .foregroundColor(textColor)
    }
}

extension View {
    func monospacedTitleText() -> some View {
        modifier(MonospacedTitleText())
    }
    
    func monospacedBodyText() -> some View {
        modifier(MonospacedBodyText())
    }
    
    func monospacedInfoText() -> some View {
        modifier(MonospacedInfoText())
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

// title text style
//struct TextStyle

// body text style


// GeneratePrimesButtonStyle
// TODO: Find out settings for default button animation in Swift
