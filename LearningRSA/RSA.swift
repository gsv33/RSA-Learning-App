//
//  RSA.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/1/22.
//

import Foundation

// Note: This is NOT a secure implementation of RSA. It is just a tool for learning
// about the algorithm.
class RSA: ObservableObject {
    struct Number: Identifiable {
        let id = UUID()
        let value: Int
    }
                        
                        
    let DIGITS_PER_CHAR = 2
    var charToNumEncoding: [Character: Int] = ["A": 11, "B": 12, "C": 13, "D": 14, "E": 15, "F": 16,
                                               "G": 17, "H": 18, "I": 19, "J": 20, "K": 21, "L": 22,
                                               "M": 23, "N": 24, "O": 25, "P": 26, "Q": 27, "R": 28,
                                               "S": 29, "T": 30, "U": 31, "V": 32, "W": 33, "X": 34,
                                               "Y": 35, "Z": 36, " ": 37]
    
    var inputMessageStr: String = "TO BE OR NOT TO BE"
    var inputMessageNum: String = ""
    
    var inputMessageNumList: [Number] = []
    var encodedMessageList: [Number] = []
    var decodedMessageList: [Number] = []
    var decodedMessageNum: String = ""
    var decodedMessageStr: String = ""
    
    var prime1: Int = 0
    var prime2: Int = 0
    
    var decodePrime1: Int = 12553
    var decodePrime2: Int = 13007
    var phi_decode: Int {
        return (decodePrime1 - 1) * (decodePrime2 - 1)
    }
    
    var publicKeyK: Int = 0
    var invPublicKeyK: Int = 0
    
    var productOfPrimes: Int = 0
    
    // number of integers relatively prime to the product of the primes
    var phi: Int {
        return (prime1 - 1) * (prime2 - 1)
    }
    
    // uses inputMessageNumList, publicKeyK, and productOfPrimes to
    // encode the message by modular exponentiation
    func encodeMessage() {
        for num in inputMessageNumList {
            let encodedNum = modExponent(base: num.value, power: publicKeyK, modulo: productOfPrimes)
            encodedMessageList.append(Number(value: encodedNum))
        }        
    }
    
    func computeInvPublicKeyK() {
        // need to find inverse of publicKeyK modulo phi_decode
        do {
            let (invK, invPhi, gcd) = try extendedEuclidean(a: publicKeyK, b: phi_decode)
            guard invK > 0 && invPhi < 0 else {
                print("Error decoding the message")
                return
            }
            
            if gcd != 1 {
                print("Incorrect primes given. Value of phi is not correct.")
            }
            
            invPublicKeyK = invK
        }
        catch {
            print("Something went wrong! You need to enter two positive integers.")
        }
    }
    
    func decodeMessage() {
        for encodedNum in encodedMessageList {
            let decodedNum = modExponent(base: encodedNum.value, power: invPublicKeyK, modulo: productOfPrimes)
            print("DecodedNum: \(decodedNum)")
            
            decodedMessageList.append(Number(value: decodedNum))
            decodedMessageNum += String(decodedNum)
        }
    }
    
    func computeProductOfPrimes() {
        productOfPrimes = prime1 * prime2
    }
    
    // an integer relatively prime to phi that completes the public key
    func computePublicKeyK() throws {

        let numDigitsPrime1 = Int(log10(Double(prime1)) + 1)
        let numDigitsPrime2 = Int(log10(Double(prime2)) + 1)
        let numDigitsK = (numDigitsPrime1 + numDigitsPrime2) / 2
        
        let randomRangeStart = Int(pow(10.0, Double(numDigitsK - 1)))
        let randomRangeEnd = Int(pow(10.0, Double(numDigitsK)))

        var gcd = 0 // gcd(phi, publicKeyK)
        var tempK = 0
        
        // calculate publicKeyK by generating random numbers and checking if gcd = 1
        while gcd != 1 {
            tempK = Int.random(in: randomRangeStart ..< randomRangeEnd)
            (_, _, gcd) = try extendedEuclidean(a: tempK, b: phi)
        }
        
        publicKeyK = tempK
    }
    
    // converts inputMessageStr to inputMessageNum using charToNumEncoding
    func stringToNumberConversion() {
        guard inputMessageStr == "" || inputMessageNum == "" else {
            return
        }
        
        for char in inputMessageStr {
            let num = charToNumEncoding[char]!
            inputMessageNum += "\(num)"
        }
    }
    
    // converts decodedMessageNum to decodedMessageStr using the inverse of charToNumEncoding
    func numberToStringConversion() {
        var numToCharEncoding: [Int: Character] = [:]
        for (char, num) in charToNumEncoding {
            numToCharEncoding.updateValue(char, forKey: num)
        }

        var tempDigits = ""
        for decodedNum in decodedMessageNum {
            tempDigits.append(decodedNum)
            if tempDigits.count == DIGITS_PER_CHAR {
                let currNum = Int(tempDigits)!
                let currChar = numToCharEncoding[currNum]
                
                decodedMessageStr.append(currChar ?? "X")
                tempDigits = ""
            }
        }
    }
    
    // splits inputNumber to an array of numbers by making sure
    // each number has fewer digits than the product of the primes
    func splitInputNumberByDigits() {
        let maxDigits = String(productOfPrimes).count
        
        guard maxDigits > 0 else {
            print("Error splitting the input number into separate numbers")
            return
        }
        
        var tempSubstring = "" // substring of entire message with < maxDigits
        
        for num in inputMessageNum {
            tempSubstring.append(num)
            
            if tempSubstring.count == maxDigits - 1 {
                inputMessageNumList.append(Number(value: Int(tempSubstring)!)) //TODO: Need to make sure these are really ints
                tempSubstring = ""
            }
        }
        
        // Add remaining substring to array, regardless of length
        if tempSubstring != "" {
            inputMessageNumList.append(Number(value: Int(tempSubstring)!))
            tempSubstring = ""
        }
    }
}
