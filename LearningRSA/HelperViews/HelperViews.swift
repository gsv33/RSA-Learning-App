//
//  HelperViews.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/25/22.
//

import SwiftUI

// This is the "More Info" button that provides more detailed
// explanations across the app's views
struct MoreInfoButton<Content: View>: View {
    @Binding var showInfoPopover: Bool
    var InfoView: Content // the info view to be displayed
    
    var body: some View {
        Button(action: {
            showInfoPopover = true
        }) {
            Label("More Info", systemImage: "info.square")
        }
        .popover(isPresented: $showInfoPopover) { InfoView }
        .monospacedBodyText()
    }
}

// Shows the entire character to number mapping used as a popover
struct MappingView: View {
    @Environment(\.dismiss) var dismiss
    
    var charToNumArr = CharacterConverter.charToNumArray
    let columns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()

            VStack {
                Text("Character to Number Mapping")
                    .monospacedTitleText().padding(5)
                                
                ScrollView {
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
                    .buttonStyle(MenuButtonStyle())
            }
        }.foregroundColor(Colors.textColor)
    }
}



struct HelperViews_Previews: PreviewProvider {
    static var previews: some View {
        MappingView()
    }
}
