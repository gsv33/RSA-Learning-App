//
//  Math.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/27/22.
//
//  This files contains the math functions needed to implement
//  a basic version of the RSA algorithm.

import Foundation

// Uses successive squaring to calculate a^k mod m
// Algorithm from "A Friendly Introduction to Number Theory", 4th edition
func modExponent(base: Int, power: Int, modulo: Int) -> Int {
    var a = base
    var k = power
    let m = modulo

    var b = 1
    
    while k >= 1 {
        if k % 2 != 0 { // if k is odd
            b = (a * b) % m
        }
        a = (a * a) % m
        k = k / 2
    }
    
    return b
}



// Extended Euclidean Algorithm
// Algorithm taken from "A Friendly Introduction to Number Theory", 4th edition

enum EuclideanAlgorithmError: Error {
    case inputsAreNotPositiveInts
}

func extendedEuclidean(a: Int, b: Int) throws -> (Int, Int, Int) {
    guard a > 0 && b > 0 else {
        throw EuclideanAlgorithmError.inputsAreNotPositiveInts
    }
    
    var x = 1, g = a, v = 0, w = b
    var q = 0, t = 0, s = 0
    
    while w != 0 {
        // g = qw + t
        q = g / w
        t = g % w
        
        s = x - q*v
        
        (x,g) = (v,w)
        (v,w) = (s,t)
    }
        
    var y = (g - a*x)/b
    
    // make sure x > 0
    if x < 0 {
        let c = (-x / b) + 1
        x += c*b
        y -= c*a
    }
        
    return (x,y,g)
}


// checks if a number is prime
func isPrime(n: Int) -> Bool {
    guard n > 1 else {
        return false
    }
    
    let sqrtN = Int(sqrt(Double(n)))
    var i = 2
    
    while i <= sqrtN {
        if n % i == 0 {
            return false
        }
        
        i += 1
    }
    return true
}

// Uses the isPrime function to generate a random prime number
// Optional int parameter: number of digits the prime should be
// TODO: Add timeout in case something goes wrong
func generatePrimeNumber(numDigits: Int = 4) -> Int {
    var p = 0
    
    let n = Double(numDigits)
    let rangeStart = Int(pow(10.0, n - 1))
    let rangeEnd = Int(pow(10.0, n))

    while isPrime(n: p) == false {
        p = Int.random(in: rangeStart ..< rangeEnd)
    }
    
    return p
}


// checks to see if given String is a prime number
// and if it is not too long
func isPrime(p: String, maxDigitsInPrime: Double = 5) -> Bool {
    guard let n = Int(p) else {
        return false
    }
    
    // if log10(n) == maxDigitsInPrime, there are 1 too many digits
    if log10(Double(n)) >= maxDigitsInPrime {
        return false
    }
    
    if isPrime(n: n) {
        return true
    }
    else {
        return false
    }
}

// checks if two inputs are unique prime numbers
// Return values:
// 1 (failure) - both primes match
// 0 (success) - two different primes
// -1 (failure) - both aren't primes
func checkInputsAreUniquePrimes(prime1: String, prime2: String) -> Int {
    let p1 = isPrime(p: prime1)
    let p2 = isPrime(p: prime2)
    
    if p1 && p2 && prime1 == prime2 { // primes cannot be the same
        return 1
    }
    else if p1 && p2 {
        return 0
    } else {
        return -1
    }
}

// checks that the inputs are unique primes and
// updates the prime image symbols and error messages in certain cases
func validateInputs(prime1: String, prime2: String,
                    primeImage1: inout String, primeImage2: inout String,
                    errorMessage: inout ErrorMessages) -> Bool {
    
    let inputsValid = checkInputsAreUniquePrimes(prime1: prime1, prime2: prime2)
    
    if inputsValid == 0 { // success
        return true
    }
    else if inputsValid == 1 { // both primes are the same
        //TODO: Set appropriate error Message if primes are too long
        primeImage1 = GlobalVars.invalidSymbol
        primeImage2 = GlobalVars.invalidSymbol
        
        errorMessage = .primesMatch
    }
    else { // inputsValid == -1, both aren't prime numbers
        errorMessage = .notPrimes
    }
    
    return false
}

