//
//  DiaryEntry.swift
//  SantaDiary
//
//  Created by Brian Veitch on 10/24/21.
//

import Foundation
import UIKit

class DiaryEntry {
    
    public var year: Int
    public var month: Int
    public var day: Int
    public var mood: String
    public var dateTime: String
    public var results: [(prompt: String, result: String)] = []
    
    init() {
        year = 2021
        month = 1
        day = 24
        mood = "Happy"
        dateTime = "10/20 at 3pm"
        self.results.append((prompt: "Mood?", result: "Good"))
    }
}
