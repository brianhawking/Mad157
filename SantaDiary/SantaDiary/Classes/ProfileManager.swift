//
//  ProfileManager.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/18/21.
//

import Foundation
import UIKit

public struct ProfileEntry: Codable {
    
    var name: String
    var image: String
    var birthDay: Date
    
    init(name: String, image: String, birthDay: Date) {
        
        self.name = name
        self.image = image
        self.birthDay = birthDay
    }
    
    func age() -> String {
        // get current day and time
        let date = Date()
        let year = Calendar.current.dateComponents([.year], from: self.birthDay, to: date).year
        return String(year!)
    }
    
}

struct ProfileManager {
    init() {}
    
    // checks if the user exists.
    func userExists(profile: ProfileEntry) -> Bool {
        // check if a folder exists in Users
        
        // path to user's profile
        let path = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0]
            .appendingPathComponent("Users")
            .appendingPathComponent(profile.name)
    
        
        // check if there's a folder for user
        if FileManager.default.fileExists(atPath: path.path) {
            return true
        }
        else {
            print("\(profile.name) does not exist.")
            return false
        }
    }
    
    // edit user's name (changes folder and profile.json)
    func changeName(from: String, to: String) {
        
        // path to user's profile
        let path = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0]
            .appendingPathComponent("Users")
        
        let old = path.appendingPathComponent(from).path
        let new = path.appendingPathComponent(to).path
        
        // Create a FileManager instance
        let fileManager = FileManager.default

        // Rename 'hello.swift' as 'goodbye.swift'
        do {
            try fileManager.moveItem(atPath: old, toPath: new)
//            try fileManager.moveItem(atPath: "hello.swift", toPath: "goodbye.swift")
        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    // edit user's profile (changes in profile.json)
    func changeImage(from: String, to: String) {}

    // if user does not exist, create a folder for user
    func createProfile(profile: ProfileEntry) -> Bool {
        
        let encoder = JSONEncoder()
       
        // add this to print json object better
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(profile)
            
            if String(data: jsonData, encoding: .utf8) != nil {
            
                // this will be the path to user's folder
                var path = FileManager.default.urls(for: .documentDirectory, in:
                    .userDomainMask)[0]
                    .appendingPathComponent("Users")
                    .appendingPathComponent(profile.name)
                
                // check if the user has a profole
                if userExists(profile: profile) {
                    print("\(profile.name) already exists.")
                }
                else {
                    // create the user's folder
                    do {
                        try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
                        print("Profile for \(profile.name) has been created.")
                        
                        // create profile file
                        path = path.appendingPathComponent("profile")
                                .appendingPathExtension("json")
                        
                        try jsonData.write(to: path)
                    }
                    catch {
                        print("error with creating file directory. \(error.localizedDescription)")
                    }
                }
            }
        }
        catch {
            print(error.localizedDescription)
            return false
        }
            
        return true
    }
 
    // get a list of profiles
    func getProfiles() -> [ProfileEntry] {
        
        var profiles: [ProfileEntry] = [] // empty list
        
        // path to profiles
        let path = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0]
            .appendingPathComponent("Users")
        
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for file in directoryContents {
                
                
                let newPath = path
                    .appendingPathComponent(file.lastPathComponent)
                    .appendingPathComponent("profile")
                    .appendingPathExtension("json")

                
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: newPath.path))
                    let entry = try JSONDecoder().decode(ProfileEntry.self, from: data)
                    
                    profiles.append(ProfileEntry(name: file.lastPathComponent as String, image: entry.image, birthDay: entry.birthDay))
            
                }
                catch {
                    print("error reading data from profile.json")
                }
                
            }
        }
        catch {
            print("ERROR accessing the users folders")
        }
        
        return profiles
    }
    
}
