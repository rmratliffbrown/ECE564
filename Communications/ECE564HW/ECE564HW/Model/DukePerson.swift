//
//  DukePerson.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/4/22.
//

import Foundation
import UIKit
import Metal

// create a base class for Person
class Person: Codable {
    var firstname: String
    var lastname: String
    var wherefrom: String
    var gender: String
    var hobbies: [String]
    var picture: String
    var id: String
    
    init(firstname: String, lastname: String, wherefrom: String, gender: String, hobbies: [String], picture: String, id: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.wherefrom = wherefrom
        self.gender = gender
        self.hobbies = hobbies
        self.picture = picture
        self.id = id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstname = try container.decode(String.self, forKey: .firstname)
        self.lastname = try container.decode(String.self, forKey: .lastname)
        self.wherefrom = try container.decode(String.self, forKey: .wherefrom)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.hobbies = try container.decode([String].self, forKey: .hobbies)
        self.picture = try container.decode(String.self, forKey: .picture)
        self.id = try container.decode(String.self, forKey: .id)
    }
    
    enum CodingKeys: String, CodingKey { case firstname, lastname, wherefrom, gender, hobbies, picture, id}
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstname, forKey: .firstname)
        try container.encode(lastname, forKey: .lastname)
        try container.encode(wherefrom, forKey: .wherefrom)
        try container.encode(gender, forKey: .gender)
        try container.encode(hobbies, forKey: .hobbies)
        try container.encode(picture, forKey: .picture)
        try container.encode(id, forKey: .id)
      }
    
}

// MARK: - DukePerson

// create a subclass for DukePerson
class DukePerson: Person, CustomStringConvertible {
    
    var netid: String
    var role: String
    var languages: [String]
    var department: String
    var degree: String
    var team: String
    var email: String
    
    // override the init for Person to add additional attributes to distinguish a DukePerson
    init(firstname: String, lastname: String, wherefrom: String, gender: String, hobbies: [String],
                     role: String, degree: String, languages: [String], picture: String, team: String, netid: String,
                     email: String, department: String, id: String) {
        self.role = role
        self.degree = degree
        self.languages = languages
        self.team = team
        self.netid = netid
        self.email = email
        self.department = department
        super.init(firstname: firstname, lastname: lastname, wherefrom: wherefrom, gender: gender, hobbies: hobbies, picture: picture, id: id)
    }
    
    /// Use this in the case that we want to create an empty person.
    convenience init() {
        self.init(firstname: "", lastname: "", wherefrom: "", gender: "Male", hobbies: [], role: "Professor", degree: "", languages: [], picture: "", team: "", netid: "", email: "", department: "", id: "")
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.netid = try container.decode(String.self, forKey: .netid)
        self.role = try container.decode(String.self, forKey: .role)
        self.languages = try container.decode([String].self, forKey: .languages)
        self.department = try container.decode(String.self, forKey: .department)
        self.degree = try container.decode(String.self, forKey: .degree)
        self.team = try container.decode(String.self, forKey: .team)
        self.email = try container.decode(String.self, forKey: .email)

        try super.init(from: decoder)

    }
    
    // CustomStringConvertible protocol to display formatted content
    var description: String {
        
        let outputInfo = "My name is \(firstname) \(lastname) and I am from \(wherefrom). My best programming language(s): \(languages.joined(separator: ",")), and my favorite hobbies: \(hobbies.joined(separator: ",")). You can reach me at \(netid)@duke.edu."
        
        return (outputInfo)
    }
    
    enum CodingKeys: String, CodingKey { case role, degree, languages, team, netid, email, department}

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try super.encode(to: encoder)
        try container.encode(role, forKey: .role)
        try container.encode(degree, forKey: .degree)
        try container.encode(languages, forKey: .languages)
        try container.encode(team, forKey: .team)
        try container.encode(netid, forKey: .netid)
        try container.encode(email, forKey: .email)
        try container.encode(department, forKey: .department)
    }
    
    func contains(searchText: String) -> Bool {
        if firstname.lowercased().contains(searchText.lowercased()) {
            return true
        }
        else if lastname.lowercased().contains(searchText.lowercased()) {
            return true
        }
        else if wherefrom.lowercased().contains(searchText.lowercased()) {
            return true
        }
        else if gender.lowercased().contains(searchText.lowercased()) {
            return true
        }
        else if firstname.lowercased().contains(searchText.lowercased()) {
            return true
        }
        else if id.lowercased().contains(searchText.lowercased()) {
            return true
        }
        else if netid.lowercased().contains(searchText.lowercased()) {
            return true
        }
        else if role.lowercased().contains(searchText.lowercased()) {
            return true
        }
        // Nested contains
        else if languages.contains(where: { $0.lowercased().contains(searchText.lowercased()) }) {
            return true
        }
        
        else if department.lowercased().contains(searchText.lowercased()) {
            return true
        }
        
        // Nested contains
        else if hobbies.contains(where: { $0.lowercased().contains(searchText.lowercased()) }) {
            return true
        }
        
        else if degree.lowercased().contains(searchText.lowercased()) {
            return true
        }
        
        else if team.lowercased().contains(searchText.lowercased()) {
            return true
        }
        
        else if email.lowercased().contains(searchText.lowercased()) {
            return true
        }

        return false
        
    }
}

