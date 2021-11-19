//
//  DiaryManager.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/3/21.
//

import Foundation
import UIKit

public struct LetterEntry: Codable {
    
    public var year: Int
    public var month: Int
    public var day: Int
    public var date: String
    public var letter: String
    public var new: Bool
    public var from: String
    
    init(letter: String, from: String) {

        // get current day and time
        let date = Date()
        let calendar = Calendar.current
        
        // get time
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let time = formatter.string(from: date)
        
        // get date
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        self.year = year
        self.month = month
        self.day = day
        self.date = time
        self.letter = letter
        self.new = true
        self.from = from
    
        print("You successfully created a diary entry object.")
    }
}

struct LetterManager {
    init() {}
    
    // converts the diary entry to JSON object.
    func saveLetter(profileName: String, entry: LetterEntry, to: String) -> Bool {
        
        let encoder = JSONEncoder()
       
        // add this to print json object better
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(entry)
            
            if String(data: jsonData, encoding: .utf8) != nil {
        
                // print to new file
                // check if the user has a profole
                if false {
//                if !userExists(profileName: profileName) {
//                    print("\(profileName) does not exist.")
                }
                else {
                    // add the entry
                    
                    do {
//                        let profileName = serialize(string: profileName)
                      
                        // pathway to specific diary entry folder
                        var pathToLetters = FileManager.default.urls(for: .documentDirectory, in:
                            .userDomainMask)[0]
                            .appendingPathComponent("Users")
                            .appendingPathComponent(profileName)
                            .appendingPathComponent(to)
                            .appendingPathComponent(String(entry.year))
                            .appendingPathComponent(String(entry.month))
                            .appendingPathComponent(String(entry.day))
                            .appendingPathComponent(String(entry.date))
                        
                        print(pathToLetters)
                            
                        do {
                            try FileManager.default.createDirectory(at: pathToLetters, withIntermediateDirectories: true, attributes: nil)
                           
                        }
                        catch {
                            print("error with creating file directory. \(error.localizedDescription)")
                            return false
                        }
                        // return letter text
                        if to == "LetterFromSanta" {
                            pathToLetters = pathToLetters.appendingPathComponent("LetterFromSanta")
                                .appendingPathExtension("json")
                        }
                        else {
                            pathToLetters = pathToLetters.appendingPathComponent("LetterToSanta")
                                .appendingPathExtension("json")
                        }
                        
                        try jsonData.write(to: pathToLetters)
                        
                        return true
                    }
                    catch {
                        print("error with saving the letter: \(error)")
                        return false
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
    func getLetter(profileName: String, date: String, to: String) -> String {
        
        // get file path to letters
        let pathToLetters = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask)[0]
            .appendingPathComponent("Users")
            .appendingPathComponent(profileName)
            .appendingPathComponent(to)
        print(pathToLetters)
        
        let enumerator = FileManager.default.enumerator(atPath: pathToLetters.path)
        
        struct LetterComponents {
            var year: String
            var month: String
            var day: String
            var name: String
        }
        
        while let filename = enumerator?.nextObject() as? String {
            print(filename)
            let components = filename.split(separator: "/")
            
            if components.count == 5 && components[3] == date && components[4] == "\(to).json" {
                // found the letter
    
                let newPath = pathToLetters
                    .appendingPathComponent(String(components[0]))
                    .appendingPathComponent(String(components[1]))
                    .appendingPathComponent(String(components[2]))
                    .appendingPathComponent(String(components[3]))
                    .appendingPathComponent(to)
                    .appendingPathExtension("json")
                
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: newPath.path))
                    let entry = try JSONDecoder().decode(LetterEntry.self, from: data)
                    
                    // update letter status
                    // change status of letter -> new = false
                    var updatedLetter = entry
                    updatedLetter.new = false
                    if(saveLetter(profileName: profileName, entry: updatedLetter, to: to)) {
                        print("letter status updated")
                    }
                    
                    // return letter text
                    if to == "LetterFromSanta" {
                        return "Dear \(profileName), \n\n\(entry.letter)"
                    }
                    else {
                        return "Dear Santa, \n\n\(entry.letter)"
                    }
                    
                }
                catch {
                    print("error. Could not retrieve letter.")
                }
            }
        }
        return "Letter is missing."
    }
    
    func getLetters(profileName: String, to: String) -> [LetterEntry] {
        
        // empty array for letters
        var letters: [LetterEntry] = []
        
        let pathToLetters = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0]
            .appendingPathComponent("Users")
            .appendingPathComponent(profileName)
            .appendingPathComponent(to)
        
        let enumerator = FileManager.default.enumerator(atPath: pathToLetters.path)
        
        var arrayOfEntries: [LetterComponents] = []
        
        struct LetterComponents {
            var year: String
            var month: String
            var day: String
            var name: String
        }
        
        // filemanager will go through all files and subdirectories
        while let filename = enumerator?.nextObject() as? String {
          
            let components = filename.split(separator: "/")

            // if the pathway has 5 components it must be in a letter entry
            // documents/users/profile/name
            // -> year/month/day/date/letter.json
            if components.count == 5 && components[4] == "\(to).json" {
                
                let element = LetterComponents(
                    year: String(components[0]),
                    month: String(components[1]),
                    day: String(components[2]),
                    name: String(components[3])
                )
                arrayOfEntries.append(element)
            }
        }
        
        
        
        // sort by most recent letter entry
        arrayOfEntries.sort {
            if Int($0.year) == Int($1.year) {
                if Int($0.month) == Int($1.month) {
                    return Int($0.day)! > Int($1.day)!
                }
                return Int($0.month)! > Int($1.month)!
            }
            return Int($0.year)! > Int($1.year)!
        }
        
//        print("NUMBER OF LETTERS IS \(arrayOfEntries.count)")
        
        // go through each entry to grab the information
        for letter in arrayOfEntries {
            
//            print(letter.name)

            let newPath = pathToLetters
                .appendingPathComponent(letter.year)
                .appendingPathComponent(letter.month)
                .appendingPathComponent(letter.day)
                .appendingPathComponent(letter.name)
                .appendingPathComponent(to)
                .appendingPathExtension("json")

            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: newPath.path))
                let entry = try JSONDecoder().decode(LetterEntry.self, from: data)
                
                letters.append(entry)
        
            }
            catch {
//                print("\(error)")
                print("error")
            }
            
        }
        return letters
    }

    
    func getLettersCount(profileName: String) -> Int {
        
        var count = 0
        let letters = getLetters(profileName: profileName, to: "LetterFromSanta")
        
        for letter in letters {
            if (letter.new == true) {
                count += 1
            }
        }
        
        return count
    }
    
}
