//
//  LearningRSATests.swift
//  LearningRSATests
//
//  Created by Govin Vatsan on 1/17/23.
//

import XCTest
@testable import LearningRSA

final class LearningRSATests: XCTestCase {

    override func setUpWithError() throws {
//        var inputMessageEng: String = "THIS IS A TEST"
//        var inputMessageNum: String = "3018192937192937113730152930"
//        var inputMessageNumList: [Number] = [Number(value: "3018192"), Number(value: "9371929"), Number(value: "3711373"), Number(value: "0152930")]
//
//        var encodedMessageNumList: [Number] = [Number(value: "4647069"), Number(value: "28956032"), Number(value: "10898488"), Number(value: "-129495095")]
//        var encodedMessageNum: String = "46470692895603210898488-120812819"
//
//        var realDecodedMessageNumList: [Number] = [Number(value: "3018192"), Number(value: "9371929"), Number(value: "3711373"), Number(value: "0152930")]
//        var realDecodedMessageNum: String = "3018192937192937113730152930"
//        var realDecodedMessageEng: String = "THIS IS A TEST"
//
//        var fakeDecodedMessageNumList: [Number] = [Number(value: "26007518"), Number(value: "19201995"), Number(value: "6333876"), Number(value: "020616234")]
//        var fakeDecodedMessageNum: String = "26007518192019956333876020616234"
//        var fakeDecodedMessageEng: String = "MXXWKXXXE XXXXXX"        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Generates a random string from the characters allowed in the RSA encoding
    func generateRandomString(strLen: Int) -> String {
        let chars = [":", "[", "~", "1", "-", "3", "7", "0", "X", "@", "'", "E", "`", "f", "D", "V", "6", "=", "k", ";", "|", ",", "W", "]", "}", "R", "d", "n", "*", "U", "8", "!", "S", "a", "Y", "s", "<", "G", "(", "H", "+", "#", "h", "x", "Q", "m", "5", "K", "Z", "B", "\"", "e", ")", "^", "_", "4", "\\", "y", "F", "b", "q", "o", "r", "w", " ", "u", "P", "L", "$", "%", "M", ">", "?", "2", "N", "i", "/", "I", "l", "9", "&", "p", "C", "j", "z", "{", "A", "c", ".", "J", "g", "O", "t", "T", "v"]
        
        var randomString = ""
        
        for _ in 1 ..< strLen + 1 {
            let r = Int.random(in: 0 ..< chars.count)
            randomString.append(chars[r])
        }
            
        return randomString
    }

    
//    func testRSAEdgeCases() {
//        
//    }
    
    // Tests whether decoded message matches the input message
    func testRSARandomStrings() {
        var rsa = RSA()
                
        for _ in 0 ..< 10000 {
            
            // generate random message
            rsa.inputMessageEng = generateRandomString(strLen: Int.random(in: 1 ... GlobalVars.maxCharsInMessage))
            
            // set encoding and decoding primes
            rsa.prime1 = generatePrimeNumber(maxNumDigits: Int.random(in: 1 ... GlobalVars.maxDigitsInPrime))
            rsa.prime2 = generatePrimeNumber(maxNumDigits: Int.random(in: 1 ... GlobalVars.maxDigitsInPrime))
            
            // check to make sure primes are not the same and have a product >= 10
            while rsa.prime1 == rsa.prime2  || rsa.prime1 * rsa.prime2 < 10 {
                rsa.prime2 = generatePrimeNumber()
            }
            
            // set real decode primes
            rsa.realDecodePrime1 = rsa.prime1
            rsa.realDecodePrime2 = rsa.prime2
            
            // set fake decode primes
            rsa.fakeDecodePrime1 = generatePrimeNumber(maxNumDigits: Int.random(in: 1 ... GlobalVars.maxDigitsInPrime))
            rsa.fakeDecodePrime2 = generatePrimeNumber(maxNumDigits: Int.random(in: 1 ... GlobalVars.maxDigitsInPrime))

            while rsa.fakeDecodePrime1 == rsa.fakeDecodePrime2  || rsa.fakeDecodePrime1 * rsa.fakeDecodePrime2 < 10 {
                rsa.fakeDecodePrime2 = generatePrimeNumber()
            }
            
            // encode message
            rsa.stringToNumberConversion()
            rsa.splitInputNumberByDigits()
            rsa.computeEncryptionKeyE()
            rsa.encodeMessage()
            
            // decode message
            rsa.computeDecryptionKeys()
            rsa.decodeRealAndFakeMessages()
            rsa.convertDecodedMessagesToEnglish()
            
            // compare input and decoded messages
            if (rsa.inputMessageEng != rsa.realDecodedMessageEng) {
                print("Input \(rsa.inputMessageEng) | Real Output: \((rsa.realDecodedMessageEng)) | Fake Output: \(rsa.fakeDecodedMessageEng)" +
                      "| Real Primes: \(rsa.prime1), \(rsa.prime2) | Fake Primes: \(rsa.fakeDecodePrime1), \(rsa.fakeDecodePrime2)")
            }
            XCTAssertEqual(rsa.inputMessageEng, rsa.realDecodedMessageEng, "Input message does not match decoded message")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
