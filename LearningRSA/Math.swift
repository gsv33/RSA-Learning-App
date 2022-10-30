//
//  Math.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 10/27/22.
//
//  This files contains the math functions needed to implement
//  a basic version of the RSA algorithm.


// Uses successive squaring to calculate a^k mod m
// Algorithm from "A Friendly Introduction to Number Theory", 4th edition
func modExponent(base: Int, power: Int, modulo: Int) -> Int {
    var a = base
    var k = power
    var m = modulo

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

