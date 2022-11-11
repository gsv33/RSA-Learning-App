//
//  CharacterConverter.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/9/22.
//
//  Responsible for the mapping between characters
//  and numbers and vice versa.

import Foundation

// stores each character and it's corresponding number
// needed for display as a list in a SwiftUI view
struct CharNumMap: Identifiable {
    let id = UUID()
    let number: Int
    let char: Character
}

struct CharacterConverter {

    static var charToNumEncoding: [Character: Int] = ["A": 11, "B": 12, "C": 13, "D": 14, "E": 15, "F": 16,
                                                      "G": 17, "H": 18, "I": 19, "J": 20, "K": 21, "L": 22,
                                                      "M": 23, "N": 24, "O": 25, "P": 26, "Q": 27, "R": 28,
                                                      "S": 29, "T": 30, "U": 31, "V": 32, "W": 33, "X": 34,
                                                      "Y": 35, "Z": 36, " ": 37]

    // necessary to display mapping in view
    var charToNumArr: [CharNumMap] = []

    init() {
        for (char, num) in CharacterConverter.charToNumEncoding {
            if char != " " {
                charToNumArr.append(CharNumMap(number: num, char: char))
            }
        }
        
        charToNumArr.sort { $0.char < $1.char }
    }
}
