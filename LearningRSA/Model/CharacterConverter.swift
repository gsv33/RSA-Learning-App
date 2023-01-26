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

    static let charToNumArray: [CharNumConversion] = [CharNumConversion(character: "A", number: "01"),
                                                      CharNumConversion(character: "B", number: "02"),
                                                      CharNumConversion(character: "C", number: "03"),
                                                      CharNumConversion(character: "D", number: "04"),
                                                      CharNumConversion(character: "E", number: "05"),
                                                      CharNumConversion(character: "F", number: "06"),
                                                      CharNumConversion(character: "G", number: "07"),
                                                      CharNumConversion(character: "H", number: "08"),
                                                      CharNumConversion(character: "I", number: "09"),
                                                      CharNumConversion(character: "J", number: "10"),
                                                      CharNumConversion(character: "K", number: "11"),
                                                      CharNumConversion(character: "L", number: "12"),
                                                      CharNumConversion(character: "M", number: "13"),
                                                      CharNumConversion(character: "N", number: "14"),
                                                      CharNumConversion(character: "O", number: "15"),
                                                      CharNumConversion(character: "P", number: "16"),
                                                      CharNumConversion(character: "Q", number: "17"),
                                                      CharNumConversion(character: "R", number: "18"),
                                                      CharNumConversion(character: "S", number: "19"),
                                                      CharNumConversion(character: "T", number: "20"),
                                                      CharNumConversion(character: "U", number: "21"),
                                                      CharNumConversion(character: "V", number: "22"),
                                                      CharNumConversion(character: "W", number: "23"),
                                                      CharNumConversion(character: "X", number: "24"),
                                                      CharNumConversion(character: "Y", number: "25"),
                                                      CharNumConversion(character: "Z", number: "26"),
                                                      CharNumConversion(character: "a", number: "27"),
                                                      CharNumConversion(character: "b", number: "28"),
                                                      CharNumConversion(character: "c", number: "29"),
                                                      CharNumConversion(character: "d", number: "30"),
                                                      CharNumConversion(character: "e", number: "31"),
                                                      CharNumConversion(character: "f", number: "32"),
                                                      CharNumConversion(character: "g", number: "33"),
                                                      CharNumConversion(character: "h", number: "34"),
                                                      CharNumConversion(character: "i", number: "35"),
                                                      CharNumConversion(character: "j", number: "36"),
                                                      CharNumConversion(character: "k", number: "37"),
                                                      CharNumConversion(character: "l", number: "38"),
                                                      CharNumConversion(character: "m", number: "39"),
                                                      CharNumConversion(character: "n", number: "40"),
                                                      CharNumConversion(character: "o", number: "41"),
                                                      CharNumConversion(character: "p", number: "42"),
                                                      CharNumConversion(character: "q", number: "43"),
                                                      CharNumConversion(character: "r", number: "44"),
                                                      CharNumConversion(character: "s", number: "45"),
                                                      CharNumConversion(character: "t", number: "46"),
                                                      CharNumConversion(character: "u", number: "47"),
                                                      CharNumConversion(character: "v", number: "48"),
                                                      CharNumConversion(character: "w", number: "49"),
                                                      CharNumConversion(character: "x", number: "50"),
                                                      CharNumConversion(character: "y", number: "51"),
                                                      CharNumConversion(character: "z", number: "52"),
                                                      CharNumConversion(character: " ", number: "53"),
                                                      CharNumConversion(character: "!", number: "54"),
                                                      CharNumConversion(character: "\"", number:"55"),
                                                      CharNumConversion(character: "#", number: "56"),
                                                      CharNumConversion(character: "$", number: "57"),
                                                      CharNumConversion(character: "%", number: "58"),
                                                      CharNumConversion(character: "&", number: "59"),
                                                      CharNumConversion(character: "\'", number:"60"),
                                                      CharNumConversion(character: "(", number: "61"),
                                                      CharNumConversion(character: ")", number: "62"),
                                                      CharNumConversion(character: "*", number: "63"),
                                                      CharNumConversion(character: "+", number: "64"),
                                                      CharNumConversion(character: ",", number: "65"),
                                                      CharNumConversion(character: "-", number: "66"),
                                                      CharNumConversion(character: ".", number: "67"),
                                                      CharNumConversion(character: "/", number: "68"),
                                                      CharNumConversion(character: ":", number: "69"),
                                                      CharNumConversion(character: ";", number: "70"),
                                                      CharNumConversion(character: "<", number: "71"),
                                                      CharNumConversion(character: "=", number: "72"),
                                                      CharNumConversion(character: ">", number: "73"),
                                                      CharNumConversion(character: "?", number: "74"),
                                                      CharNumConversion(character: "@", number: "75"),
                                                      CharNumConversion(character: "[", number: "76"),
                                                      CharNumConversion(character: "\\", number:"77"),
                                                      CharNumConversion(character: "]", number: "78"),
                                                      CharNumConversion(character: "^", number: "79"),
                                                      CharNumConversion(character: "_", number: "80"),
                                                      CharNumConversion(character: "`", number: "81"),
                                                      CharNumConversion(character: "{", number: "82"),
                                                      CharNumConversion(character: "|", number: "83"),
                                                      CharNumConversion(character: "}", number: "84"),
                                                      CharNumConversion(character: "~", number: "85"),
                                                      CharNumConversion(character: "0", number: "86"),
                                                      CharNumConversion(character: "1", number: "87"),
                                                      CharNumConversion(character: "2", number: "88"),
                                                      CharNumConversion(character: "3", number: "89"),
                                                      CharNumConversion(character: "4", number: "90"),
                                                      CharNumConversion(character: "5", number: "91"),
                                                      CharNumConversion(character: "6", number: "92"),
                                                      CharNumConversion(character: "7", number: "93"),
                                                      CharNumConversion(character: "8", number: "94"),
                                                      CharNumConversion(character: "9", number: "95")]
    
    static let charToNumEncoding: [Character: String] =  ["A": "01",
                                                          "B": "02",
                                                          "C": "03",
                                                          "D": "04",
                                                          "E": "05",
                                                          "F": "06",
                                                          "G": "07",
                                                          "H": "08",
                                                          "I": "09",
                                                          "J": "10",
                                                          "K": "11",
                                                          "L": "12",
                                                          "M": "13",
                                                          "N": "14",
                                                          "O": "15",
                                                          "P": "16",
                                                          "Q": "17",
                                                          "R": "18",
                                                          "S": "19",
                                                          "T": "20",
                                                          "U": "21",
                                                          "V": "22",
                                                          "W": "23",
                                                          "X": "24",
                                                          "Y": "25",
                                                          "Z": "26",
                                                          "a": "27",
                                                          "b": "28",
                                                          "c": "29",
                                                          "d": "30",
                                                          "e": "31",
                                                          "f": "32",
                                                          "g": "33",
                                                          "h": "34",
                                                          "i": "35",
                                                          "j": "36",
                                                          "k": "37",
                                                          "l": "38",
                                                          "m": "39",
                                                          "n": "40",
                                                          "o": "41",
                                                          "p": "42",
                                                          "q": "43",
                                                          "r": "44",
                                                          "s": "45",
                                                          "t": "46",
                                                          "u": "47",
                                                          "v": "48",
                                                          "w": "49",
                                                          "x": "50",
                                                          "y": "51",
                                                          "z": "52",
                                                          " ": "53",
                                                          "!": "54",
                                                          "\"":"55",
                                                          "#": "56",
                                                          "$": "57",
                                                          "%": "58",
                                                          "&": "59",
                                                          "\'":"60",
                                                          "(": "61",
                                                          ")": "62",
                                                          "*": "63",
                                                          "+": "64",
                                                          ",": "65",
                                                          "-": "66",
                                                          ".": "67",
                                                          "/": "68",
                                                          ":": "69",
                                                          ";": "70",
                                                          "<": "71",
                                                          "=": "72",
                                                          ">": "73",
                                                          "?": "74",
                                                          "@": "75",
                                                          "[": "76",
                                                          "\\":"77",
                                                          "]": "78",
                                                          "^": "79",
                                                          "_": "80",
                                                          "`": "81",
                                                          "{": "82",
                                                          "|": "83",
                                                          "}": "84",
                                                          "~": "85",
                                                          "0": "86",
                                                          "1": "87",
                                                          "2": "88",
                                                          "3": "89",
                                                          "4": "90",
                                                          "5": "91",
                                                          "6": "92",
                                                          "7": "93",
                                                          "8": "94",
                                                          "9": "95"]
                                                          
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
