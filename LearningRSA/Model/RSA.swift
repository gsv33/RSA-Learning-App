//
//  RSA.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 11/1/22.
//

import Foundation

struct Number: Identifiable {
    let id = UUID()
    let value: String
}

// This class is only needed to create a second environmentObject for the explore RSA views.
class RSAExplore: RSA {}

// Note: This is NOT a secure implementation of RSA. It is just a tool for learning
// about the algorithm.
class RSA: ObservableObject {
                                                
    let DIGITS_PER_CHAR = 2
    let charToNumEncoding = CharacterConverter.charToNumEncoding
    
    // Input Messages
    var inputMessageEng: String = ""
    var inputMessageNum: String = ""
    var inputMessageNumSplit: String = ""
    var inputMessageNumList: [Number] = []

    // Encoded Messages
    var encodedMessageNum: String = ""
    var encodedMessageNumSplit: String = ""
    var encodedMessageNumList: [Number] = []
    
    // Real Decoded Messages
    var realDecodedMessageEng: String = ""
    var realDecodedMessageNum: String = ""
    var realDecodedMessageNumSplit: String = ""
    var realDecodedMessageNumList: [Number] = []

    // Fake Decoded Messages
    var fakeDecodedMessageEng: String = ""
    var fakeDecodedMessageNum: String = ""
    var fakeDecodedMessageNumSplit: String = ""
    var fakeDecodedMessageNumList: [Number] = []
    
    var prime1: Int = 0
    var prime2: Int = 0
    
    var realDecodePrime1: Int = 0
    var realDecodePrime2: Int = 0
    var realDecodePhi: Int {
        return (realDecodePrime1 - 1) * (realDecodePrime2 - 1)
    }

    var fakeDecodePrime1: Int = 0
    var fakeDecodePrime2: Int = 0
    var fakeDecodePhi: Int {
        return (fakeDecodePrime1 - 1) * (fakeDecodePrime2 - 1)
    }
    
    var encryptionKeyE: Int = 0
    var realDecryptionKeyD: Int = 0
    var fakeDecryptionKeyD: Int = 0
    
    var productOfPrimes: Int {
        return prime1 * prime2
    }
    var inputNumDigits: Int { // number of digits in each number before encoding
        return String(productOfPrimes).count - 1
    }
    var encodedNumDigits: Int { // number of digits in each number after encoding
        return String(productOfPrimes).count
    }
    
    // number of integers relatively prime to the product of the primes
    var encodePhi: Int {
        return (prime1 - 1) * (prime2 - 1)
    }
        
    // uses inputMessageNumList, encryptionKeyE, and productOfPrimes to
    // encode the message by modular exponentiation
    func encodeMessage() {
        encodedMessageNumList = []
        encodedMessageNum = ""
        encodedMessageNumSplit = ""
        
        var numVal = 0
        var encodedNum = ""
        
        for inputNum in inputMessageNumList {
            numVal = Int(inputNum.value)! //TODO: Make sure this is really an integer
            
            encodedNum = String(modExponent(base: numVal, power: encryptionKeyE, modulo: productOfPrimes))
            
            // pad encodedNum with leading zeros if necessary
            if encodedNum.count < encodedNumDigits {
                let numZeros = encodedNumDigits - encodedNum.count
                encodedNum = String(repeating: "0", count: numZeros) + encodedNum
            }
            
            encodedMessageNumList.append(Number(value: encodedNum))
            encodedMessageNum.append(encodedNum)
            encodedMessageNumSplit += encodedNum + " "
        }        
    }
    
    // calculate inverse of encryptionKeyE modulo phi
    func computeDecryptionKeyD(phi: Int) -> Int {
        let (invKey, invPhi, gcd) = extendedEuclidean(a: encryptionKeyE, b: phi)
                
        return invKey
    }
    
    func computeDecryptionKeys() {
        realDecryptionKeyD = computeDecryptionKeyD(phi: realDecodePhi)
        fakeDecryptionKeyD = computeDecryptionKeyD(phi: fakeDecodePhi)
    }
    
    func decodeMessage(decryptionKeyD: Int, decodedMessageList: inout [Number], decodedMessageNum: inout String, decodedMessageNumSplit: inout String) {
        decodedMessageList = []
        decodedMessageNum = ""
        decodedMessageNumSplit = ""
        
        var numVal = 0
        var decodedNum = ""
        
        for encodedNum in encodedMessageNumList {
            numVal = Int(encodedNum.value)!

            decodedNum = String(modExponent(base: numVal, power: decryptionKeyD, modulo: productOfPrimes))
            
            // pad decodedNum with leading zeros if necessary
            if decodedNum.count < inputNumDigits {
                let numZeros = inputNumDigits - decodedNum.count
                decodedNum = String(repeating: "0", count: numZeros) + decodedNum
            }
                                   
            decodedMessageList.append(Number(value: decodedNum))
            decodedMessageNum += decodedNum
            decodedMessageNumSplit += decodedNum + " "
        }
    }
    
    func decodeRealAndFakeMessages() {
        decodeMessage(
            decryptionKeyD: realDecryptionKeyD,
            decodedMessageList: &realDecodedMessageNumList,
            decodedMessageNum: &realDecodedMessageNum,
            decodedMessageNumSplit: &realDecodedMessageNumSplit
        )

        decodeMessage(
            decryptionKeyD: fakeDecryptionKeyD,
            decodedMessageList: &fakeDecodedMessageNumList,
            decodedMessageNum: &fakeDecodedMessageNum,
            decodedMessageNumSplit: &fakeDecodedMessageNumSplit
        )
    }
        
    // an integer relatively prime to phi that completes the encryption key
    // TODO: Need to add time-out feature here
    func computeEncryptionKeyE() -> Bool {

        let numDigitsPrime1 = Int(log10(Double(prime1)) + 1)
        let numDigitsPrime2 = Int(log10(Double(prime2)) + 1)
        let numDigitsE = (numDigitsPrime1 + numDigitsPrime2) / 2
        
        let randomRangeStart = Int(pow(10.0, Double(numDigitsE - 1)))
        let randomRangeEnd = Int(pow(10.0, Double(numDigitsE)))

        var gcd = 0 // gcd(phi, encryptionKeyE)
        var tempE = 0
        
        // calculate encryptionKeyE by generating random numbers and checking if gcd = 1
        while gcd != 1 {
            tempE = Int.random(in: randomRangeStart ..< randomRangeEnd)
            (_, _, gcd) = extendedEuclidean(a: tempE, b: encodePhi) // TODO: Under what conditions should this return false?
        }
        
        encryptionKeyE = tempE
        return true
    }
    
    // converts inputMessageEng to inputMessageNum using charToNumEncoding
    func stringToNumberConversion() -> Bool {
        inputMessageNum = ""
        guard inputMessageEng != "" else {
            return false
        }

        for char in inputMessageEng {
            guard let num = charToNumEncoding[char] else {
                return false
            }
            
            inputMessageNum += num
        }
        
        return true
    }
    
    // converts decodedMessageNum to decodedMessageStr using the inverse of charToNumEncoding
    func numberToStringConversion(decodedMessageNum: String, decodedMessageStr: inout String) {
        decodedMessageStr = ""
        let padding = String(repeating: "0", count: DIGITS_PER_CHAR)
        
        var numToCharEncoding: [String: Character] = [:]
        for (char, num) in charToNumEncoding {
            numToCharEncoding.updateValue(char, forKey: num)
        }

        var tempDigits = ""
        for decodedNum in decodedMessageNum {
            tempDigits.append(decodedNum)
            if tempDigits.count == DIGITS_PER_CHAR && tempDigits != padding {
                let currNum = tempDigits
                let currChar = numToCharEncoding[currNum]
                
                decodedMessageStr.append(currChar ?? "X")
                tempDigits = ""
            }
        }
    }
    
    func convertDecodedMessagesToEnglish() {
        numberToStringConversion(decodedMessageNum: realDecodedMessageNum, decodedMessageStr: &realDecodedMessageEng)
        numberToStringConversion(decodedMessageNum: fakeDecodedMessageNum, decodedMessageStr: &fakeDecodedMessageEng)
    }
    
    // splits inputNumber to an array of numbers by making sure
    // each number has fewer digits than the product of the primes
    func splitInputNumberByDigits() {
        inputMessageNumList = []
        inputMessageNumSplit = ""
        
        guard inputNumDigits > 0 else {
            print("Error splitting the input number into separate numbers")
            return
        }
        
        var substring = "" // substring of entire message with < maxDigits
        
        for num in inputMessageNum {
            substring.append(num)
            
            if substring.count == inputNumDigits {
                inputMessageNumList.append(Number(value: substring))
                inputMessageNumSplit += substring + " "
                substring = ""
            }
        }
        
        // Pad the remaining characters with 0s to get a message of desired size
        if substring != "" {
            let paddedStr = substring.padding(toLength: inputNumDigits, withPad: "0", startingAt: 0)
            inputMessageNumList.append(Number(value: paddedStr))
            inputMessageNumSplit += paddedStr + " "
        }
    }
    
    func resetAllValues() {
        // Input Messages
        inputMessageEng = ""
        inputMessageNum = ""
        inputMessageNumSplit = ""
        inputMessageNumList = []

        // Encoded Messages
        encodedMessageNum = ""
        encodedMessageNumSplit = ""
        encodedMessageNumList = []
        
        // Real Decoded Messages
        realDecodedMessageEng = ""
        realDecodedMessageNum = ""
        realDecodedMessageNumSplit = ""
        realDecodedMessageNumList = []

        // Fake Decoded Messages
        fakeDecodedMessageEng = ""
        fakeDecodedMessageNum = ""
        fakeDecodedMessageNumSplit = ""
        fakeDecodedMessageNumList = []
        
        prime1 = 0
        prime2 = 0
        
        realDecodePrime1 = 0
        realDecodePrime2 = 0

        fakeDecodePrime1 = 0
        fakeDecodePrime2 = 0
        
        encryptionKeyE = 0
        realDecryptionKeyD = 0
        fakeDecryptionKeyD = 0
    }
}
