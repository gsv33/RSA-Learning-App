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

// Note: This is NOT a secure implementation of RSA. It is just a tool for learning
// about the algorithm.
class RSA: ObservableObject {
                                                
    let DIGITS_PER_CHAR = 2
    let charToNumEncoding = CharacterConverter.charToNumEncoding
    
    //TODO: Replace placeholder numbers
    var inputMessageEng: String = "THIS IS A TEST"
    var inputMessageNum: String = "3018192937192937113730152930"
    var inputMessageNumList: [Number] = [Number(value: "3018192"), Number(value: "9371929"), Number(value: "3711373"), Number(value: "0152930")]
    
    var encodedMessageNumList: [Number] = [Number(value: "4647069"), Number(value: "28956032"), Number(value: "10898488"), Number(value: "-129495095")]
    var encodedMessageNum: String = "46470692895603210898488-120812819"
    
    var realDecodedMessageNumList: [Number] = [Number(value: "3018192"), Number(value: "9371929"), Number(value: "3711373"), Number(value: "0152930")]
    var realDecodedMessageNum: String = "3018192937192937113730152930"
    var realDecodedMessageEng: String = "THIS IS A TEST"

    var fakeDecodedMessageNumList: [Number] = [Number(value: "26007518"), Number(value: "19201995"), Number(value: "6333876"), Number(value: "020616234")]
    var fakeDecodedMessageNum: String = "26007518192019956333876020616234"
    var fakeDecodedMessageEng: String = "MXXWKXXXE XXXXXX" // TODO: Need to change encoding scheme used (ascii?)

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
    
    var encryptionKeyE: Int = 2079
    var realDecryptionKeyD: Int = 19000319
    var fakeDecryptionKeyD: Int = 4440983
    
    var productOfPrimes: Int = 31090771
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
        }        
    }
    
    // calculate inverse of encryptionKeyE modulo phi
    func computeDecryptionKeyD(phi: Int) -> Int {
        do {
            let (invKey, invPhi, gcd) = try extendedEuclidean(a: encryptionKeyE, b: phi)
            guard invKey > 0 && invPhi < 0 else {
                print("Error decoding the message")
                return -1
            }
            
            if gcd != 1 {
                print("Incorrect primes given. Value of phi is not correct.")
            }
            
            return invKey
        }
        catch {
            print("Something went wrong! You need to enter two positive integers.")
            return -1
        }
    }
    
    func computeDecryptionKeys() {
        realDecryptionKeyD = computeDecryptionKeyD(phi: realDecodePhi)
        fakeDecryptionKeyD = computeDecryptionKeyD(phi: fakeDecodePhi)
    }
    
    // TODO: Combine with encode message function?
    func decodeMessage(decryptionKeyD: Int, decodedMessageList: inout [Number], decodedMessageNum: inout String) {
        decodedMessageList = []
        decodedMessageNum = ""
        
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
        }
    }
    
    func decodeRealAndFakeMessages() {
        decodeMessage(
            decryptionKeyD: realDecryptionKeyD,
            decodedMessageList: &realDecodedMessageNumList,
            decodedMessageNum: &realDecodedMessageNum
        )

        decodeMessage(
            decryptionKeyD: fakeDecryptionKeyD,
            decodedMessageList: &fakeDecodedMessageNumList,
            decodedMessageNum: &fakeDecodedMessageNum
        )
    }
    
    func computeProductOfPrimes() {
        productOfPrimes = prime1 * prime2
    }
    
    // an integer relatively prime to phi that completes the encryption key
    func computeEncryptionKeyE() throws {

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
            (_, _, gcd) = try extendedEuclidean(a: tempE, b: encodePhi)
        }
        
        encryptionKeyE = tempE
    }
    
    // converts inputMessageEng to inputMessageNum using charToNumEncoding
    func stringToNumberConversion() {
        inputMessageNum = ""
        guard inputMessageEng != "" else {
            return
        }

        for char in inputMessageEng {
            let num = charToNumEncoding[char]!
            inputMessageNum += num
        }
    }
    
    // converts decodedMessageNum to decodedMessageStr using the inverse of charToNumEncoding
    func numberToStringConversion(decodedMessageNum: String, decodedMessageStr: inout String) {
        var numToCharEncoding: [String: Character] = [:]
        for (char, num) in charToNumEncoding {
            numToCharEncoding.updateValue(char, forKey: num)
        }

        var tempDigits = ""
        for decodedNum in decodedMessageNum {
            tempDigits.append(decodedNum)
            if tempDigits.count == DIGITS_PER_CHAR {
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
        
        guard inputNumDigits > 0 else {
            print("Error splitting the input number into separate numbers")
            return
        }
        
        var substring = "" // substring of entire message with < maxDigits
        
        for num in inputMessageNum {
            substring.append(num)
            
            if substring.count == inputNumDigits {
                guard let _ = Int(substring) else { //TODO: Need to handle this error
                    print("Error. Invalid int entered")
                    return
                }
                
                inputMessageNumList.append(Number(value: substring))
                substring = ""
            }
        }
        
        // Pad the remaining characters with 0s to get a message of desired size
        if substring != "" {
            guard let _ = Int(substring) else { //TODO: Need to handle this error
                print("Error. Invalid int entered")
                return
            }

            let paddedStr = substring.padding(toLength: inputNumDigits, withPad: "0", startingAt: 0)
            inputMessageNumList.append(Number(value: paddedStr))
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
