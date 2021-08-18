import UIKit

// Instructions
// 1) Assign a list of unique random numbers to 5 variables and 5 constants.
// 2) Place them into an array
// 3) Sort them into ascending order
// 4) Store them into a dictionary using key values for easy retrieval of the highest and lowest number.
// 5) Change a variable or constant and show me it works!

// assign unique random numbers to 5 variables and 5 constants

// variables
var randomVar1 = 89
var randomVar2 = 1
var randomVar3 = 2
var randomVar4 = 5
var randomVar5 = 34

// constants
let randomConst1 = 3
let randomConst2 = 4
let randomConst3 = 8
let randomConst4 = 28
let randomConst5 = 460

// array to contain above values
var arrayOfNumbers: [Int] = []

// add variables and constants to array
arrayOfNumbers.append(randomVar1)
arrayOfNumbers.append(randomVar2)
arrayOfNumbers.append(randomVar3)
arrayOfNumbers.append(randomVar4)
arrayOfNumbers.append(randomVar5)

arrayOfNumbers.append(randomConst1)
arrayOfNumbers.append(randomConst2)
arrayOfNumbers.append(randomConst3)
arrayOfNumbers.append(randomConst4)
arrayOfNumbers.append(randomConst5)

print(arrayOfNumbers)

// sort the array in ascending order
arrayOfNumbers.sort()
print(arrayOfNumbers)

// loop over array, enter the low and high into a dictionary
var dictionaryOfNumbers: [String: Int] = [:]

// note: Not sure if I'm putting all the values into the dictionary or just a low and high value.

dictionaryOfNumbers["low"] = arrayOfNumbers[0]
dictionaryOfNumbers["high"] = arrayOfNumbers[arrayOfNumbers.count - 1]

print("Low: ", dictionaryOfNumbers["low"]!)
print("High: ", dictionaryOfNumbers["high"]!)
