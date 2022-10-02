//
//  DataManager.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/19/22.
//

import Foundation
import UIKit

// protocol to handle if people change
protocol DataManagerDelegate: AnyObject {
    func peopleChanged()
}

// Handles working with our data locally within our app only (it doesn't interact with the database)
class DataManager {
    static var shared: DataManager = DataManager()
    
    // Represents some (unknown to us) object, that we know has to implement the `peopleChanged()` method (since that is a requirement for conforming types to that protocol).
    weak var delegate: DataManagerDelegate? = nil
    
    var people: [DukePerson] = [] {
        didSet {
            let success = JSONManager.shared.saveToJSON(people)
            print("Saved: \(success)")
            printPeople()
            delegate?.peopleChanged()
        }
    }
    
    private init() {
        self.people = JSONManager.shared.loadNewJSON()
        self.people = self.people.isEmpty ? JSONManager.shared.loadOriginalJSON() ?? [] : self.people
    }
    
    // only made function to print people for testing
    func printPeople() {
        print(people.count)
        people.forEach { person in
            print("\(person.firstname): \(person.netid)")
//            if person.picture == "" {
//                person.picture = (UIImage(named: "default")?.toString())!
//            }
        }
    }
    
    func update(person: DukePerson) {
//        // move update function
//        // optional handling, else -> default: ""
//        person.firstname = fnameField.text ?? ""
//        person.lastname = lnameField.text ?? ""
//        person.wherefrom = fromField.text ?? ""
//        person.gender = genderSelect
//        person.hobbies = hobbyField.text?.components(separatedBy: ", ") ?? [String]()
//        person.role = roleField
//        // missing degree
//        person.languages = progLangField.text?.components(separatedBy: ", ") ?? [String]()
//        // missing picture - will add
//        person.picture = personImageView.image?.toString() ?? ""
//        // missing team
//        // missing email
//        // missing department
//        // missing id
        
        // set 'i' to the index of where the person.netid matches the input netid
        if let i = people.firstIndex(where: { $0.netid == person.netid }) {
            // This block runs only if i is saved to a value. If firstIndex() returns nil, then this is skipped.
            people[i] = person
        }
    }
    
    func add(person: DukePerson){
        people.append(person)
    }
    
    func remove(person: DukePerson){
        people.removeAll(where: { $0.netid == person.netid })
    }
    
    func find(firstname: String, lastname: String) -> DukePerson? {
        return people.first(where: { $0.firstname == firstname && $0.lastname == lastname })
    }
}
