//
//  RSA.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/1/22.
//

import Foundation

struct Number: Identifiable {
    let id = UUID()
    let value: Int
}

// Note: This is NOT a secure implementation of RSA. It is just a tool for learning
// about the algorithm.
class RSA: ObservableObject {
                                                
    let DIGITS_PER_CHAR = 2
    var charToNumEncoding: [Character: Int] = ["A": 11, "B": 12, "C": 13, "D": 14, "E": 15, "F": 16,
                                               "G": 17, "H": 18, "I": 19, "J": 20, "K": 21, "L": 22,
                                               "M": 23, "N": 24, "O": 25, "P": 26, "Q": 27, "R": 28,
                                               "S": 29, "T": 30, "U": 31, "V": 32, "W": 33, "X": 34,
                                               "Y": 35, "Z": 36, " ": 37]
    
    //TODO: Replace placeholder numbers
    var inputMessageStr: String = "THIS IS A TEST"
    var inputMessageNum: String = "3018192937192937113730152930"
    
    var inputMessageNumList: [Number] = [Number(value: 3018192), Number(value: 9371929), Number(value: 3711373), Number(value: -120812819)]
    var encodedMessageList: [Number] = [Number(value: 4647069), Number(value: 28956032), Number(value: 10898488), Number(value: -129495095)]
    var encodedMessageStr: String = "46470692895603210898488-120812819"
    
    var decodedMessageList: [Number] = []
    var decodedMessageNum: String = ""
    var decodedMessageStr: String = ""
    
    var prime1: Int = 4241
    var prime2: Int = 7331
    
    var realDecodePrime1: Int = 4241
    var realDecodePrime2: Int = 7331
    var realDecodePhi: Int {
        return (realDecodePrime1 - 1) * (realDecodePrime2 - 1)
    }

    var fakeDecodePrime1: Int = 1871
    var fakeDecodePrime2: Int = 2377
    var fakeDecodePhi: Int {
        return (fakeDecodePrime1 - 1) * (fakeDecodePrime2 - 1)
    }
    
    
    var publicKeyK: Int = 0
    var invPublicKeyK: Int = 0
    
    var productOfPrimes: Int = 31090771
    
    // number of integers relatively prime to the product of the primes
    var phi: Int {
        return (prime1 - 1) * (prime2 - 1)
    }
    
    // uses inputMessageNumList, publicKeyK, and productOfPrimes to
    // encode the message by modular exponentiation
    func encodeMessage() {
        encodedMessageList = []
        encodedMessageStr = ""
        
        var numVal = 0
        var leadingZerosAdjustment = ""
        var encodedNum = 0
        
        for num in inputMessageNumList {
            numVal = num.value
            
            if numVal < 0 {
                leadingZerosAdjustment = String(String(numVal).prefix(2)) // e.g. -450 -> -4
                numVal = Int(String(numVal).dropFirst(2))! // e.g. -450 -> 50
                
                encodedNum = modExponent(base: numVal, power: publicKeyK, modulo: productOfPrimes)
                encodedNum = Int("\(leadingZerosAdjustment)\(encodedNum)")!
            }
            else {
                encodedNum = modExponent(base: numVal, power: publicKeyK, modulo: productOfPrimes)
            }
            
            encodedMessageList.append(Number(value: encodedNum))
            encodedMessageStr.append(String(encodedNum))
            leadingZerosAdjustment = ""
        }        
    }
    
    func computeInvPublicKeyK() {
        // need to find inverse of publicKeyK modulo realDecodePhi
        do {
            let (invK, invPhi, gcd) = try extendedEuclidean(a: publicKeyK, b: realDecodePhi)
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
        decodedMessageList = []
        
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
        inputMessageNum = ""
        guard inputMessageStr != "" else {
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
        inputMessageNumList = []
        let maxDigits = String(productOfPrimes).count
        
        guard maxDigits > 0 else {
            print("Error splitting the input number into separate numbers")
            return
        }
        
        var substring = "" // substring of entire message with < maxDigits
        
        for num in inputMessageNum {
            substring.append(num)
            
            if substring.count == maxDigits - 1 {
                let adjustedSubstring = adjustLeadingZeros(originalStr: substring)
                
                inputMessageNumList.append(Number(value: Int(adjustedSubstring)!)) //TODO: Need to make sure these are really ints
                substring = ""
            }
        }
        
        // Add remaining substring to array, regardless of length
        if substring != "" {
            let adjustedSubstring = adjustLeadingZeros(originalStr: substring)
            
            inputMessageNumList.append(Number(value: Int(adjustedSubstring)!))
            substring = ""
        }
    }
    
    // NOTE: special handling for leading 0s in a number
    // Change 0 to -1 and multiply by number of leading 0s
    // (e.g. "00123" --> "-2123")
    // originalStr must contain only numbers "0-9"
    func adjustLeadingZeros(originalStr: String) -> String {
        guard let originalInt = Int(originalStr) else {
            return "Error. Invalid String entered."
        }
        guard originalInt >= 0 else {
            return "Error. Negative Number entered"
        }
        
        if originalInt == 0 {
            return "0"
        }
        
        var adjustedStr = ""
        var leadingZeros = 0
        
        for c in originalStr {
            if c == "0" {
                leadingZeros -= 1
            }
            else {
                break
            }
        }
        
        if leadingZeros < 0 {
            adjustedStr = String(leadingZeros) + String(originalInt)
        }
        else {
            adjustedStr = originalStr
        }
        
        return adjustedStr
    }
}
