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

// Used for displaying the encoding in a list
// Otherwise the dictionary won't maintain order
struct CharNumConversion {
    let character: Character
    let number: String
}



struct CharacterConverter {

    static let charToNumArray: [CharNumConversion] = [CharNumConversion(character: "A", number: "00"),
                                                      CharNumConversion(character: "B", number: "01"),
                                                      CharNumConversion(character: "C", number: "02"),
                                                      CharNumConversion(character: "D", number: "03"),
                                                      CharNumConversion(character: "E", number: "04"),
                                                      CharNumConversion(character: "F", number: "05"),
                                                      CharNumConversion(character: "G", number: "06"),
                                                      CharNumConversion(character: "H", number: "07"),
                                                      CharNumConversion(character: "I", number: "08"),
                                                      CharNumConversion(character: "J", number: "09"),
                                                      CharNumConversion(character: "K", number: "10"),
                                                      CharNumConversion(character: "L", number: "11"),
                                                      CharNumConversion(character: "M", number: "12"),
                                                      CharNumConversion(character: "N", number: "13"),
                                                      CharNumConversion(character: "O", number: "14"),
                                                      CharNumConversion(character: "P", number: "15"),
                                                      CharNumConversion(character: "Q", number: "16"),
                                                      CharNumConversion(character: "R", number: "17"),
                                                      CharNumConversion(character: "S", number: "18"),
                                                      CharNumConversion(character: "T", number: "19"),
                                                      CharNumConversion(character: "U", number: "20"),
                                                      CharNumConversion(character: "V", number: "21"),
                                                      CharNumConversion(character: "W", number: "22"),
                                                      CharNumConversion(character: "X", number: "23"),
                                                      CharNumConversion(character: "Y", number: "24"),
                                                      CharNumConversion(character: "Z", number: "25"),
                                                      CharNumConversion(character: "a", number: "26"),
                                                      CharNumConversion(character: "b", number: "27"),
                                                      CharNumConversion(character: "c", number: "28"),
                                                      CharNumConversion(character: "d", number: "29"),
                                                      CharNumConversion(character: "e", number: "30"),
                                                      CharNumConversion(character: "f", number: "31"),
                                                      CharNumConversion(character: "g", number: "32"),
                                                      CharNumConversion(character: "h", number: "33"),
                                                      CharNumConversion(character: "i", number: "34"),
                                                      CharNumConversion(character: "j", number: "35"),
                                                      CharNumConversion(character: "k", number: "36"),
                                                      CharNumConversion(character: "l", number: "37"),
                                                      CharNumConversion(character: "m", number: "38"),
                                                      CharNumConversion(character: "n", number: "39"),
                                                      CharNumConversion(character: "o", number: "40"),
                                                      CharNumConversion(character: "p", number: "41"),
                                                      CharNumConversion(character: "q", number: "42"),
                                                      CharNumConversion(character: "r", number: "43"),
                                                      CharNumConversion(character: "s", number: "44"),
                                                      CharNumConversion(character: "t", number: "45"),
                                                      CharNumConversion(character: "u", number: "46"),
                                                      CharNumConversion(character: "v", number: "47"),
                                                      CharNumConversion(character: "w", number: "48"),
                                                      CharNumConversion(character: "x", number: "49"),
                                                      CharNumConversion(character: "y", number: "50"),
                                                      CharNumConversion(character: "z", number: "51"),
                                                      CharNumConversion(character: " ", number: "52"),
                                                      CharNumConversion(character: "!", number: "53"),
                                                      CharNumConversion(character: "\"", number:  "54"),
                                                      CharNumConversion(character: "#", number: "55"),
                                                      CharNumConversion(character: "$", number: "56"),
                                                      CharNumConversion(character: "%", number: "57"),
                                                      CharNumConversion(character: "&", number: "58"),
                                                      CharNumConversion(character: "\'", number:  "59"),
                                                      CharNumConversion(character: "(", number: "60"),
                                                      CharNumConversion(character: ")", number: "61"),
                                                      CharNumConversion(character: "*", number: "62"),
                                                      CharNumConversion(character: "+", number: "63"),
                                                      CharNumConversion(character: ",", number: "64"),
                                                      CharNumConversion(character: "-", number: "65"),
                                                      CharNumConversion(character: ".", number: "66"),
                                                      CharNumConversion(character: "/", number: "67"),
                                                      CharNumConversion(character: ":", number: "68"),
                                                      CharNumConversion(character: ";", number: "69"),
                                                      CharNumConversion(character: "<", number: "70"),
                                                      CharNumConversion(character: "=", number: "71"),
                                                      CharNumConversion(character: ">", number: "72"),
                                                      CharNumConversion(character: "?", number: "73"),
                                                      CharNumConversion(character: "@", number: "74"),
                                                      CharNumConversion(character: "[", number: "75"),
                                                      CharNumConversion(character: "\\", number: "76"),
                                                      CharNumConversion(character: "]", number: "77"),
                                                      CharNumConversion(character: "^", number: "78"),
                                                      CharNumConversion(character: "_", number: "79"),
                                                      CharNumConversion(character: "`", number: "80"),
                                                      CharNumConversion(character: "{", number: "81"),
                                                      CharNumConversion(character: "|", number: "82"),
                                                      CharNumConversion(character: "}", number: "83"),
                                                      CharNumConversion(character: "~", number: "84"),
                                                      CharNumConversion(character: "0", number: "85"),
                                                      CharNumConversion(character: "1", number: "86"),
                                                      CharNumConversion(character: "2", number: "87"),
                                                      CharNumConversion(character: "3", number: "88"),
                                                      CharNumConversion(character: "4", number: "89"),
                                                      CharNumConversion(character: "5", number: "90"),
                                                      CharNumConversion(character: "6", number: "91"),
                                                      CharNumConversion(character: "7", number: "92"),
                                                      CharNumConversion(character: "8", number: "93"),
                                                      CharNumConversion(character: "9", number: "94")]
    
    static let charToNumEncoding: [Character: String] =  ["A": "00",
                                                          "B": "01",
                                                          "C": "02",
                                                          "D": "03",
                                                          "E": "04",
                                                          "F": "05",
                                                          "G": "06",
                                                          "H": "07",
                                                          "I": "08",
                                                          "J": "09",
                                                          "K": "10",
                                                          "L": "11",
                                                          "M": "12",
                                                          "N": "13",
                                                          "O": "14",
                                                          "P": "15",
                                                          "Q": "16",
                                                          "R": "17",
                                                          "S": "18",
                                                          "T": "19",
                                                          "U": "20",
                                                          "V": "21",
                                                          "W": "22",
                                                          "X": "23",
                                                          "Y": "24",
                                                          "Z": "25",
                                                          "a": "26",
                                                          "b": "27",
                                                          "c": "28",
                                                          "d": "29",
                                                          "e": "30",
                                                          "f": "31",
                                                          "g": "32",
                                                          "h": "33",
                                                          "i": "34",
                                                          "j": "35",
                                                          "k": "36",
                                                          "l": "37",
                                                          "m": "38",
                                                          "n": "39",
                                                          "o": "40",
                                                          "p": "41",
                                                          "q": "42",
                                                          "r": "43",
                                                          "s": "44",
                                                          "t": "45",
                                                          "u": "46",
                                                          "v": "47",
                                                          "w": "48",
                                                          "x": "49",
                                                          "y": "50",
                                                          "z": "51",
                                                          " ": "52",
                                                          "!": "53",
                                                          "\"": "54",
                                                          "#": "55",
                                                          "$": "56",
                                                          "%": "57",
                                                          "&": "58",
                                                          "\'": "59",
                                                          "(": "60",
                                                          ")": "61",
                                                          "*": "62",
                                                          "+": "63",
                                                          ",": "64",
                                                          "-": "65",
                                                          ".": "66",
                                                          "/": "67",
                                                          ":": "68",
                                                          ";": "69",
                                                          "<": "70",
                                                          "=": "71",
                                                          ">": "72",
                                                          "?": "73",
                                                          "@": "74",
                                                          "[": "75",
                                                          "\\": "76",
                                                          "]": "77",
                                                          "^": "78",
                                                          "_": "79",
                                                          "`": "80",
                                                          "{": "81",
                                                          "|": "82",
                                                          "}": "83",
                                                          "~": "84",
                                                          "0": "85",
                                                          "1": "86",
                                                          "2": "87",
                                                          "3": "88",
                                                          "4": "89",
                                                          "5": "90",
                                                          "6": "91",
                                                          "7": "92",
                                                          "8": "93",
                                                          "9": "94"]
                                                          
    static var charToNumEncodingOld: [Character: Int] = ["A": 11, "B": 12, "C": 13, "D": 14, "E": 15, "F": 16,
                                                         "G": 17, "H": 18, "I": 19, "J": 20, "K": 21, "L": 22,
                                                         "M": 23, "N": 24, "O": 25, "P": 26, "Q": 27, "R": 28,
                                                         "S": 29, "T": 30, "U": 31, "V": 32, "W": 33, "X": 34,
                                                         "Y": 35, "Z": 36, " ": 37]

    // sort necessary to display mapping in view
//    var charToNumArr: [CharNumMap] = []

//    init() {
//        for (char, num) in CharacterConverter.charToNumEncoding {
//            if char != " " {
//                charToNumArr.append(CharNumMap(number: num, char: char))
//            }
//        }
//
//        charToNumArr.sort { $0.char < $1.char }
//    }
}
