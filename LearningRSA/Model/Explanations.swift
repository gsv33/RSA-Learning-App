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
                ScrollView {
                    Text(title)
                        .monospacedTitleText()
                    
                    Text("Welcome to the Learning RSA App walkthrough! This will be an overview of how the RSA algorithm works.")
                        .padding()
                    
                    Text("This walkthrough is broken into two parts: the encoding section, where you will learn how RSA encrypts a message, and the decoding section, where you will learn how RSA decrypts a message.")
                        .padding()
                    
                    Text("To help make this clear, at each step in the walkthrough, you will encode, and then decode your own message.")
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
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
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
                ScrollView {
                    Text("Message to Numbers")
                        .monospacedTitleText()
                    
                    Text("Before we can encrypt your message, we need to convert your text to numbers.")
                        .padding()
                    
                    Text("The way RSA works is that first we convert your message into a sequence of numbers. Then, we apply a mathematical function to transform this sequence into a different, encrypted sequence of numbers. So the first step is to convert the message text into numbers.")
                        .padding()
                    
                    Text("This doesn't need to be secure. The only thing that matters here is that the sender and receiver both know how each character in the message is converted into a number.").padding()
                    
                    Text("In this app, we just use a simple conversion scheme that covers the most commonly used English letters and punctuation and assigns a 2-digit number to each character.").padding()
                }
                
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
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
                ScrollView {
                    Text("Why Prime Numbers?")
                        .monospacedTitleText()
                    
                    Group {
                        
                        Text("Prime numbers are the building blocks of the RSA cryptosystem. This is because of the fundamental theorem of arithmetic, which says that every positive integer has a unique prime factorization.").padding()
                        
                        Text("For example, the prime factors are the blue numbers below.").padding()
                        
                        Text("187 = ") + Text("11").foregroundColor(Colors.outputColor)
                        + Text(" x ") + Text("17").foregroundColor(Colors.outputColor)
                        
                        Text("2623 = ") + Text("43").foregroundColor(Colors.outputColor)
                        + Text(" x ") + Text("61").foregroundColor(Colors.outputColor)
                        
                        Text("133577 = ") + Text("223").foregroundColor(Colors.outputColor)
                        + Text(" x ") + Text("599").foregroundColor(Colors.outputColor)
                        
                        Text("Because of this property, if we multiply two prime numbers P and Q together to get M = PQ, that product M will only have one prime factorization, namely the two numbers that we multiplied together, P and Q.").padding()
                        
                        Text("Now there are two fundamental concepts behind the RSA algorithm. (1) It is easy to multiple large numbers together. (2) It is very difficult to find the prime factorization of a large number (even for a computer).").padding()
                        
                        Text("As you continue the walkthrough, you will see that the prime numbers will be used to create two keys, a public encryption key that anyone can use to encode a message, and a private decryption key, which will be used to decode the message and will be known only to its owner.")
                            .padding()
                        
                        Text("The relationship between these two keys is directly related to the relationship between M and its prime factors, P and Q. In fact, it is because M is very difficult to factor that we can create a public key, based on M, without compromising our private key, based on P and Q.")
                            .padding()
                        
                        Text("Keep in mind that in this app, we use small prime numbers so that it's easier to understand what's going on, but in a practical implementation, the prime numbers would be hundreds of digits long.")
                            .padding()
                    }
                }
                
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
            .monospacedBodyText()
        }
    }
}

struct GeneratePublicKeyInfoView: View {
    @Environment(\.dismiss) var dismiss
    let title = "Encryption Key"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    Text(title)
                        .monospacedTitleText()
                    
                    Text("Now that we have our message and our prime numbers, we need to create a public and private key. Your public key, or your encryption key, is made up of two parts. The first part is the product of your two prime numbers. Given two prime numbers P and Q, let M = P x Q. ")
                        .padding()
                    
                    (Text("Now here's the really important thing to remember, the logic that underlies the entire security of the cryptosystem.") +
                     Text(" Factoring large numbers is very difficult.").fontWeight(.heavy).foregroundColor(Colors.lightRed) +
                     Text(" If you were given a number M and you knew that M was the product of two prime numbers P and Q, how would you know what P and Q are?")).padding()

                    Text("For example, given the number 357407, how would you know that 357407 = 419 x 853, where 419 and 853 are both prime? Now in a real application M is hundreds of digits long, making it virtually impossible to try and factor. Because of this fact, we can make M public without worrying that P and Q will be compromised, and this is the core idea underlying RSA security.").padding()

                    Text("The second part of your public key is a number, E, that is relatively prime to (P - 1) x (Q - 1). Now this number, (P - 1) x (Q - 1), is extremely important to the algorithm and it's represented with the greek symbol phi, Φ.").padding()
                    
                    Text("Φ = (P - 1) x (Q - 1) is the number of positive integers less than M that have no common factors with M. In fact, the number Φ is why we are keeping P and Q secret. If P and Q were compromised, Φ would also be compromised. Later, we'll see just exactly how Φ is used in the algorithm.").padding()
                    
                    Text("For now, all that you need to know is that the combination of the two numbers E and M make up your encryption key.").padding()

                }
                
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
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
                ScrollView {
                    Text("Splitting up the Message")
                        .monospacedTitleText()

                    Text("There's one little detail that we need to take care of before we can actually begin encoding your message. Right now, your message is one, very big number. Before we can encode it, we need to break it up into a sequence of much smaller numbers.").padding()
                    
                    Text("As you'll see next, the encoding process relies on a type of math called modular arithmetic. You can think of this like \"clock-math\". On a 12-hour clock, after the number 12, we start back at 1. And if you add 3 hours to 10 o'clock, you get 1 o'clock, not 13 o'clock.").padding()
                    
                    Text("The encoding process uses the same type of math, except instead of the number 12, we use the number M, where M is the product of the prime numbers you chose earlier. Now for this to work properly, all the numbers we encode have to be less than M. So all we're doing here is splitting the numbers into smaller pieces that are individually each less than M.").padding()
                    
                    Text("One last thing, you might notice that the very last number has extra 0s on the end. This is called padding, and is used to make sure that all the numbers are the same size. For example, if your message is \"12345\", and M = 103, you would split up your message into: 12, 34, and 50. Note that each of the new numbers is now less than 103 and has 2 digits.").padding()
                }
                            
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
                
            }
            .padding(.top)
            .monospacedBodyText()
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
                ScrollView {
                    Text(title)
                        .monospacedTitleText()

                    Text("Now we can finally encode your message. The important thing to keep in mind when encoding is that however we encode your message, it needs to be reversible. There must be a way to decode it back to exactly the same message. To do this, we take advantage of some special properties of modular arithmetic.").padding()

                    (Text("1) Modular exponentiation, or calculating the value of\nX") +
                     Text("\(UnicodeCharacters.superscriptE)").font(.title2) +
                    Text(" mod M, can be done quickly on a computer using a technique called the method of successive squaring."))
                    .padding()

                    Text("2) If E and Φ are co-prime, then there's an integer solution to \n(D x E) - (Φ x C) = 1. This means that as long as we know E and Φ, we can calculate D. The relationship between D and E is important, as we'll see later.").padding()

                    Text("3) For the specific combination of numbers that we have chosen, namely where M is the product of two primes, and E and Φ are co-prime, the numbers D and E allow us to create a reversible mathematical transformation. Specifically, we can take each input number X and calculate a new, encoded number Y using the equation:").padding()

                    Text("Y = X")
                    + Text("\(UnicodeCharacters.superscriptE)").font(.title2)
                    + Text(" mod M")

                    Text("Applying this equation to each of our input numbers gives us our encoded message. Later, we'll see how the relationship between E and D allows us to create a decoding equation that reverses this process.").padding()
                }
                
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
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
                ScrollView {
                    Text(title)
                        .monospacedTitleText()
                    
                    Text("The first step in decoding the message is to enter the same prime numbers used to encode it. However, it's not specifically the prime numbers that we are keeping secret, it's phi, \nΦ = (P - 1) x (Q - 1). Remember that Φ is the number of positive integers less than M that have no common factors with M.").padding()
                    
                    Text("Φ is the real decryption key that lets you decode the message. We keep P and Q private because if they were compromised, Φ would be really easy to calculate.")
                        .padding()

                    Text("You might be wondering how difficult it is to calculate Φ without knowing P and Q. It's extremely difficult. It would require you to find the prime factors of M. Of course, for small numbers like we use in this app, it's easy to do on a computer, but for large values of M, in the hundreds of digits, it's practically impossible.").padding()
                }
                
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
            .monospacedBodyText()
        }
    }
}

struct DecodingMathInfoView: View {
    @Environment(\.dismiss) var dismiss
    let title = "Decoding Equation"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    Text(title)
                        .monospacedTitleText()
                    
                    Text("When we used modular exponentiation to encode the message, we mentioned that the process had to be reversible. Remember that we created our encoded number using the equation:").padding()

                    Text("Y = X")
                    + Text("\(UnicodeCharacters.superscriptE)").font(.title2)
                    + Text(" mod M")

                    Text("Also, recall that because E and Φ are co-prime, there's a solution to (D x E) - (Φ x C) = 1, where all the variables are integers. The relationship between D and E is important. They are called inverses modulo Φ, which means if we know D, we can reverse the encoding process.").padding()

                    Text("In order to calculate D, we must know E, which is part of the encryption key and is therefore publicly available, and we must know Φ, which can only be calculated if you know the original encoding primes, P and Q.").padding()

                    Text("Once we know D, all we have to do to decode the message is swap out the E in the encoding equation and replace it with D. This reverses the encoding process, and now we can take each encoded number Y and get back its corresponding original number X using the equation:").padding()

                    Text("X = Y")
                    + Text("\(UnicodeCharacters.superscriptD)").font(.title2)
                    + Text(" mod M")
                    
                    Text("Keep in mind that this won't work for just any combination of numbers. We've carefully chosen the numbers used in the algorithm to make sure that both of the equations above are true. Specifically, the properties we need to make sure that the algorithm works correctly are: (1) M is the product of prime numbers, (2) E and Φ are co-prime, and (3) (D x E) - (Φ x C) = 1.").padding()
                }
                
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
            .monospacedBodyText()
        }
    }
}

struct PrivateKeyInfoView: View {
    @Environment(\.dismiss) var dismiss
    let title = "Decryption Key"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    Text(title)
                        .monospacedTitleText()
                 
                    (Text("In order to decode our message with the equation, ") +
                    Text("X = Y") +
                    Text("\(UnicodeCharacters.superscriptD)").font(.title2) +
                    Text(" mod M") +
                    Text(", we need to find M and D. Together, this combination of numbers (M, D) is called the decryption key."))
                    .padding()
                    
                    Text("The first number, M, is easy to get, because it's also part of the publicly available encryption key. The second number is trickier. To find D, we need to solve\n(D x E) - (Φ x C) = 1. We already know the value of E from the encryption key, so all we need to do is find Φ. This is where we make use of the secret prime numbers.").padding()
                         
                    Text("Given the prime numbers P and Q that were used to encode the message, we can easily get Φ using the equation Φ = (P - 1) x (Q - 1). Once we have Φ, we can plug Φ and E into (D x E) - (Φ x C) = 1 and solve for D using a method called the euclidean algorithm. This completes the decryption key.").padding()

                    Text("But suppose you didn't know the correct values for P and Q. Then it would be nearly impossible to find the correct decryption key to break the encryption code. For a hacker, finding the identity of Φ is by far the hardest part of breaking the RSA cryptosystem. Once you know Φ, solving for D and then decoding the message are both computationally easy. But if you don't know Φ, then to find it you would need to break M into its prime factors, P and Q, which is virtually impossible for very large values of M.").padding()
                }
                
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
            .monospacedBodyText()
        }
    }
}

struct DecodedMessageInfoView: View {
    @Environment(\.dismiss) var dismiss
    let title = "Message Decoding"
    
    var body: some View {
        ZStack {
            Colors.backgroundColor.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    Text(title)
                        .monospacedTitleText()
                    
                    (Text("This is almost the same as the encoding step. We take our decryption key (M, D), and our decoding equation, ") +
                    Text("X = Y") +
                    Text("\(UnicodeCharacters.superscriptD)").font(.title2) +
                    Text(" mod M") +
                    Text(", and for each encoded number Y, we plug in the values and use modular exponentiation to calculate the corresponding input number, X."))
                    .padding()
                    
                    Text("Once we have our input numbers, the last step is to combine each individual input number into one large, continuous number to get back our original numeric message.").padding()

                    Text("Note that the same process is done using both the real decryption key and the fake decryption key, the only difference is the numbers returned by the procedure.").padding()

                    
                }
                
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
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
                ScrollView {
                    Text("Numbers to Text")
                        .monospacedTitleText()
                    
                    Text("Now that we've recovered the input message, the very last step is to convert it back into text. This just reverses the very first step of the algorithm, where we converted our text to numbers. All we have to do is make sure we use the same character to number mapping as before.").padding()
                    
                    Text("Note that you should have gotten two very different messages. The message that was decoded with the correct prime numbers should exactly match your original message. The message that was decoded with the wrong prime numbers should make absolutely no sense.").padding()
                    
                    Text("Hopefully this gives you a sense of how important prime numbers are to the security of the RSA cryptosystem, and how just changing those two numbers can make your message completely undecipherable.").padding()
                }
                
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
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
                ScrollView {
                    Text("What is RSA?")
                        .monospacedTitleText()
                    
                    Text("RSA is a widely used cryptography algorithm. It's a way to send and receive messages securely over the internet.")
                        .padding()
                    
                    Text("There are two components to RSA. An encryption key that lets you encode a message for someone else, and a decryption key that lets you decode a message meant only for you.")
                        .padding()
                    
                    Text("The relationship between these two keys, and the security of the entire algorithm, is based on a few interesting properties of prime numbers and modular arithmetic.").padding()
                    
                    Text("The walkthrough will give you an overview of how RSA works.")
                        .padding()
                    
                }
                Button("Dismiss") { dismiss() }
                    .purpleButtonStyle()
                    .padding()
            }
            .padding(.top)
            .monospacedBodyText()
        }
    }
}


struct Explanations_Previews: PreviewProvider {
    static var previews: some View {
        PrivateKeyInfoView()
    }
}
