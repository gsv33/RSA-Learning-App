//
//  Explanations.swift
//  LearningRSA
//
//  Created by Govin Vatsan on 12/19/22.
//
//  Stores the detailed explanations for each step of the process

import SwiftUI

struct EnterMessageInfoView: View {
    @Environment(\.dismiss) var dismiss
    let title = "Enter Message"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text(title).monospacedTitleText()
                
                ScrollView {
                    Text("Welcome to the Learning RSA App step-by-step tutorial! This will be an overview of how the RSA algorithm works.")
                        .padding()
                    
                    Text("This tutorial is broken into two parts, the encoding section, where you will learn how RSA encrypts a message, and the decoding section, where you will learn how RSA decrypts a message.")
                        .padding()
                    
                    Text("To help make this clear, at each step in this tutorial, you will encode, and then decode your own message.")
                        .padding()
                    
                    Group {
                        Text("Look out for the ") +
                        (Text(Image(systemName: "info.square")) + Text(" More Info "))
                            .foregroundColor(Colors.textColor) +
                        Text("buttons on each page. They will give you the details on exactly what is happening mathematically at each step of algorithm.")
                    }.padding()
                        .monospacedBodyText()
                }
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
            }
            .monospacedBodyText()
        }
    }
}

struct MessageEncodingInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                
                Text("Message to Numbers Conversion")
                    .monospacedTitleText()
                
                ScrollView {
                    Text("Before we can encrypt your message, we need to convert it to numbers.")
                        .padding()
                    
                    Text("The way RSA works is that first we transform your message to a sequence of numbers. Then, we apply a mathematical function to encrypt this sequence as a different sequence of numbers. So the first step is to convert the message to a bunch of numbers.")
                        .padding()
                    
                    Text("This doesn't need to be secure. The only thing that matters here is that the sender and receiver both know how the letters are converted into numbers").padding()
                    
                    Text("In this app, we just use a simple conversion scheme that covers the most commonly used English letters and punctuation (called the ASCII set). In real implementations, this would scale up to create encodings for other languages, symbols, emojis, etc (known as the Unicode set).").padding()
                }
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
            }
            .monospacedBodyText()
            
        }
    }
}

struct EnterPrimesInfoView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack{
                Text("Why Prime Numbers?")
                    .monospacedTitleText()
                    .padding()

                ScrollView {
                    
                    Text("Prime numbers are the building blocks of the RSA cryptosystem. This is because of the fundamental theorem of arithmetic, which says that every single positive integer has a unique prime factorization.").padding()
                    
                    Text("These are the blue numbers below.").padding()
                    
                    Text("187 = ") + Text("11").foregroundColor(Colors.outputColor)
                    + Text(" x ") + Text("17").foregroundColor(Colors.outputColor)

                    Text("2623 = ") + Text("43").foregroundColor(Colors.outputColor)
                    + Text(" x ") + Text("61").foregroundColor(Colors.outputColor)

                    Text("133577 = ") + Text("223").foregroundColor(Colors.outputColor)
                    + Text(" x ") + Text("599").foregroundColor(Colors.outputColor)

                    Text("Because of this property, if we multiply two prime numbers p and q together to get m = pq, that product m will only have one prime factorization, namely the two numbers that we multiplied together, p and q.").padding()

                    Text("Now we're starting to get into the math of RSA. There are two fundamental concepts behind the RSA algorithm. (1) It is easy to multiple large numbers together. (2) It is very difficult to find the prime factorization of a large number (even for a computer).").padding()

                    Text("In this app, we use small prime numbers so that it's easier to understand what's going on, but in a practical implementation, the prime numbers would be hundreds of digits long.")
                        .padding()

                    Text("The prime numbers will be used to create two keys, a public key that anyone can use to encode a message, and a private key, which only the receiver knows, which will be used to decode the message. This way, only the intended recipient can decode a message.")
                        .padding()

                    Text("So the first step to encoding your message is choosing the prime numbers you want to use!")
                        .padding()

        
                    
                }
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
            }
            .monospacedBodyText()
        }
    }
}

struct GeneratePublicKeyInfoView: View {
    @Environment(\.dismiss) var dismiss
    let title = "Generating the Encryption Key"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text(title)
                    .monospacedTitleText()
                    .padding([.top, .bottom])

                ScrollView {
                    
                    Text("Now that we have our message and our prime numbers, we need to create a public and private key. Your public key, or your encryption key, is made up of two parts. The first part is the product of your two prime numbers. Given two prime numbers p and q, let m = p x q. ")
                        .padding()
                    
                    
                    
                    (Text("Now here's the really important thing to remember, the logic that underlies the entire security of the cryptosystem.") +
                     Text(" Factoring numbers is very difficult.").fontWeight(.heavy).foregroundColor(Colors.outputColor) +
                     Text(" If you were given a number m and you knew that m was the product of two prime numbers p and q, how would you know what p and q are?")).padding()

                    Text("For example, given the number 357407, how would you know that 357407 = 419 x 853, where 419 and 853 are both prime numbers?. Now in a real application m is hundreds of digits long, making it virtually impossible to try and factor m. This is why we can make m public without worrying that p and q will be compromised, and this is the core idea underlying RSA security.").padding()

                    Text("The second part of your public key is a number, E, that is relatively prime to (p - 1) x (q - 1). Now this number, (p - 1) x (q - 1), is extremely important to the algorithm and it's represented with the greek symbol phi Φ.").padding()
                    
                    Text("Φ = (p - 1) x (q - 1) is the number of positive integers less than m that have no common factors with m. In fact, it's why we are keeping p and q secret. Because if p and q were compromised, Φ would also be compromised. Later, we'll get into just exactly how Φ is used in the algorithm.").padding()
                    
                    Text("For now, all that you need to know is that the combination of the two numbers E and M make up your encryption key.").padding()

                }
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
            }
            .monospacedBodyText()
        }
    }
}


struct SplitNumbersInfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text("Splitting up the Message")
                    .monospacedTitleText()
                    .padding()

                ScrollView {
                    Text("There's one little detail that we need to take care of before we can actually begin encoding the message. Right now, your message is one, very big, number. Before we can encode it, we need to break it up into a series of much smaller numbers.").padding()
                    
                    Text("As you'll see next, the encoding relies on a form of math called modular arithmetic. You can think of this like \"clock-math\". On a 12-hour clock, after the number 12, we start back at 1. And if you add 3 hours to 10 o'clock, you get 1 o'clock, not 13 o'cock.").padding()
                    
                    // INSERT PICTURE OF CLOCK HERE.
                    
                    Text("The encoding process uses the same type of math, except instead of the number \"12\", we use the number m, where m is the product of the prime numbers you chose earlier. For this to work properly, all the numbers we encode have to be less than m. So all we're doing here is splitting the numbers into smaller pieces that are all less than m.").padding()
                    
                    
                    Text("One last thing, you might notice that the very last number has extra 0s on the very end. This is called padding, and is used to make sure that all the numbers are the same size. For example, if your message is 12345, and M = 103, you would split up your numbers into: 12, 34, and 50. Note that each of the new numbers is now less than 103 and has 2 digits.").padding()
                }
                            
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
                    .padding(.top)
                
            }.monospacedBodyText()
        }
    }
    
}

struct EncodeMessageInfoView: View {
    @Environment(\.dismiss) var dismiss
    let title = "Encoding the Message"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text(title)
                    .monospacedTitleText()
                    .padding([.top])

                ScrollView {

                    Text("Now we can finally encode your message. The important thing to keep in mind when encoding is that however we encode your message, it needs to be reversible. That is, however we encode your message, there must be a way to decode it back to exactly the same message, and moreover, both the encoding and decoding need to be computationally feasible. To do this, we take advantage of some special properties of modular arithmetic.").padding()

                    Text("Modular exponentiation, or calculating the value of X\(UnicodeCharacters.superscriptE) mod m, can be done quickly on a computer using a technique called the method of successive squaring.").padding()

                    Text("If gcd(E, Φ) = 1, then there's a solution to (D x E) - (Φ x Y) = 1, where all the variables are integers. We use a method called the Euclidean Algorithm to calculate this. The relationship between D and E is important, as you'll see below.").padding()

                    Text("Finally, and this is important, for the specific combination of numbers that we have chosen, namely where M is the product of prime numbers, and gcd(E, Φ) = 1, the numbers D and E allow us to create a reversible mathematical transformation. Specifically, if we take our input number X and calculate a new number Y,").padding()

                    Text("Y = X^E mod M")

                    Text("This number, E, is an important part of your encryption key. Its corresponding number, D, is an important part of your decryption key. Later, we'll see how the decryption key gets made, which takes the number Y as input and return back X.").padding()
                }
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
                    .padding(.top)
            }
            .monospacedBodyText()
        }
    }
}

struct EnterDecodePrimesInfoView: View {
    @Environment(\.dismiss) var dismiss
    let title = "Decoding Primes"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text(title)
                    .monospacedTitleText()
                    .padding([.top])

                ScrollView {
                    Text("Just like when you encode your message, the first thing to do when you decode is to enter your prime numbers. The thing to keep in mind is that it's not specifically the prime numbers that we are keeping secret, it's Φ = (p - 1) x (q - 1). This number, which is the number of positive integers less than m that have no common factors with m, is the real key that lets you decode the message. We keep p and q private because if they were compromised, Φ would be really easy to calculate.")
                        .padding()

                    Text("You might be wondering how difficult it is to calculate Φ without knowing p and q. It's extremely difficult. It would require you to factor m into p and q. Of course, for small numbers like what we use in this app, it's easy to do this on a computer, but for large values of m, in the hundreds of digits, it's basically impossible.").padding()
                }
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
                    .padding(.top)
            }
            .monospacedBodyText()
        }
    }
}

struct DecodingMathInfoView: View {
    @Environment(\.dismiss) var dismiss
    let title = "Decoding Math Info View"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text(title)
                    .monospacedTitleText()
                    .padding([.top, .bottom])

                ScrollView {
                    
                    Text("When we used modular exponentiation to encode the message, we mentioned that the process had to be reversible. Typically, we say that such a process is invertible. Remember that we created our encoded number Y using:").padding()

                    Text("Y = X\(UnicodeCharacters.superscriptE) mod M")
                        .font(.system(.title3, design: .monospaced, weight: .medium))

                    Text("Now because gcd(E, Φ) = 1, there's a solution to (D x E) - (Φ x Y) = 1, where all the variables are integers. We use a method called the Euclidean Algorithm to calculate this. The relationship between D and E is important. They are called inverses modulo Φ, which is just a fancy way of saying that the equation (D x E) - (Φ x Y) = 1 has a solution where all the variables are integers.").padding()

                    Text("Using, this newly calculated number, D, we can reverse the encoding process to use Y as our input and get X as our output with the equation:").padding()

                    Text("X = Y\(UnicodeCharacters.superscriptD) mod M")
                        .font(.system(.title3, design: .monospaced, weight: .medium))

                    Text("So all we have to do is the same process of modular exponentiation that we used to encode the message, just with a different exponent.").padding()

                    Text("The thing to remember is that this won't work for just any combination of numbers. All the specific numbers we chose so far are used to make sure that these two equations are true, that you can reverse the transformation from X to Y just by changing the exponent. Specifically, this is true where M is the product of prime numbers, gcd(D, Φ) = 1, and (D x E) - (Φ x Y) = 1.").padding()
                }
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
                    .padding(.top)
            }
            .monospacedBodyText()
        }
    }
}

struct PrivateKeyInfoView: View {
    @Environment(\.dismiss) var dismiss
    let title = "Decryption Key Generation"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text(title)
                    .monospacedTitleText()
                    .padding([.top, .bottom])

                ScrollView {
                 
                    Text("Here we're just working through the steps described earlier. In order to apply the equation, X = Y\(UnicodeCharacters.superscriptD) mod M, we need to find M and D. Together, this combination of numbers (M, D) is called the decryption key.").padding()
                    
                    Text("The first number, M, is easy to get, because it's also a part of the publicly accessible encryption key. The second number is trickier. To find D, we need to solve (D x E) - (Φ x Y) = 1. We already know the value of E from the public key, so all we need to do is find Φ. This is where we make use of the secret prime numbers.").padding()
                         
                    Text("Given the prime numbers P and Q that were used to encode the message, we can solve Φ = (P - 1) x (Q - 1) to easily get Φ. Now once we have Φ, we can plug Φ and E into (D x E) - (Φ x Y) = 1 and solve for D. This completes the decryption key.").padding()

                    Text("But suppose you didn't know the correct values for P and Q. Then it would be nearly impossible to find the correct decryption key to break the encryption code. For a hacker, finding the identity of Φ is by far the hardest part of breaking the RSA algorithm. Once you know Φ, solving for D and then decoding the message are both computationally easy. But if you don't know Φ, then to find it you would need to break M into its prime factors, P and Q, which is basically impossible for very large values of M.").padding()
                }
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
                    .padding(.top)
            }
            .monospacedBodyText()
        }
    }
}

struct DecodedMessageInfoView: View {
    @Environment(\.dismiss) var dismiss
    let title = "Decoding the Message"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text(title)
                    .monospacedTitleText()
                    .padding([.top, .bottom])

                ScrollView {
                    
                    Text("This is almost the same as the encoding step. We take our decryption key (M, D), and our decoding equation, X = Y\(UnicodeCharacters.superscriptD) mod M$, and for each encoded message Y, we plug in the values and once again use modular exponentiation to calculate our original message, X.").padding()
                    
                    Text("Then, all we do is combine each individual number X  into one large, continuous number to get our original message. This last step is just to undo the step before encoding where we split our number into several smaller numbers.").padding()

                    Text("The exact same process is done using both the real decryption key and the fake decryption key, the only difference is the numbers returned by the procedure.").padding()

                    
                }
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
                    .padding(.top)
            }
            .monospacedBodyText()
        }
    }
}

struct NumbersToTextInfoView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text("Decoded Message Translation")
                    .monospacedTitleText()
                    .padding()
                
                Text("You should have gotten two very different messages. The message that was decoded with the correct prime numbers should exactly match your input.").padding()
                
                Text("The message that was decoded with the wrong prime numbers should make absolutely no sense.").padding()
                
                Text("The idea is to give you a sense of how important prime numbers are to the security of the RSA cryptosystem, and so that you can see how just changing the two numbers can make your message completely undecipherable.").padding()
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
                    .padding()
            }
            .monospacedBodyText()
        }
    }
}

struct RSAOverviewView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                Text("What is RSA?")
                    .monospacedTitleText()
                    .padding()
                
                Text("RSA is a widely used cryptography algorithm. It's a way to send and receive messages securely over the internet.")
                    .padding()
                
                Text("There are two components to RSA. An encryption key that lets you encode a message for someone else, and a decryption key that lets you decode a message meant only for you.")
                    .padding()
                
                Text("The relationship between these two keys, and the security of the entire algorithm, is based on interesting properties of prime numbers and modular arithmetic.").padding()
                
                Text("The walkthrough will give you an overview of how RSA works.")
                    .padding()
                
                Button("Dismiss") { dismiss() }
                    .buttonStyle(MenuButtonStyle())
                    .padding()
            }
            .monospacedBodyText()
        }
    }
}


struct Explanations_Previews: PreviewProvider {
    static var previews: some View {
        DecodedMessageInfoView()
    }
}
