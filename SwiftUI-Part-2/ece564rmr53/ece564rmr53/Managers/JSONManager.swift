//
//  JSONManager.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/4/22.
//

import Foundation

/// This class is the only place in your project that should interact with the JSON file.
class JSONManager {
    static var shared = JSONManager()
    
    private init() {}

    func loadData() -> [DukePerson]  {
        guard let url = Bundle.main.url(forResource: "ECE564Cohort", withExtension: "json")
        else {
            print("JSON file not found")
            return []
        }
        
        let data = try? Data(contentsOf: url)
        do {
            let people: [DukePerson] = try JSONDecoder().decode([DukePerson].self, from: data!)
            return people
        } catch {
            print("Error loading JSON data: \(error)")
            return []
        }
    }
}
