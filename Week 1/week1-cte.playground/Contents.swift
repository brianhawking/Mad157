import UIKit

// Instructions

// Design a Class using the 5 step process that calculates what year your 64th birthday will be in.
// Step 1 - Give Your Class A Descriptive Name
// Step 2 - Define Your Properties And Variables (Attributes)
// Step 3 - Initialize Your Properties And Variables
// Step 4 - Define Your Functions/Methods (Behaviours)
// Step 5 - Instantiate Your Class

class Person {
    var name: String
    var birthYear: Int
    
    init(name: String, birthYear: Int) {
        self.name = name
        self.birthYear = birthYear
    }
    
    // calcualtes what year you will be a certain age
    func whatYearWillIBe(age: Int) -> String {
        if age < 0 {
            return "This age is not valid."
        }
        
        let year = self.birthYear + age
        return "\(self.name) will be \(age) in the year \(year)"
    }
}

var person = Person(name: "Brian", birthYear: 1983)
print(person.whatYearWillIBe(age: -7))
 
