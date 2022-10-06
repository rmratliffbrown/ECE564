//
//  JSONManager.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/4/22.
//

import Foundation

var roles = Role.allCases
var genders = Gender.allCases


// role enum
enum Role: String, CaseIterable, CustomStringConvertible, Codable{
    case Professor, TA, Student, Other
    
    var description: String{
        rawValue
    }

}

// gender enum
enum Gender: String, CaseIterable, CustomStringConvertible, Codable{
    case Male, Female, Other, Unknown
    
    var description: String {
      rawValue
    }
}

extension DukePerson : Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(netid) //etc
    }
    
    static func == (lhs: DukePerson, rhs: DukePerson) -> Bool {
        return lhs.netid == rhs.netid
    }
}

class DukePerson: Codable, CustomStringConvertible, Identifiable {
    var firstname: String
    var lastname: String
    var wherefrom: String
    var gender: String
    var hobbies: [String]
    var role: String
    var degree: String
    var languages: [String]
    var picture: String
    var team: String
    var netid: String
    var email: String
    var department: String
    var id: String
    
    static let all: [DukePerson] = Bundle.main.decode(file: "ECE564Cohort.json")

    enum CodingKeys: String, CodingKey {
        case firstname = "firstname"
        case lastname = "lastname"
        case wherefrom = "wherefrom"
        case gender = "gender"
        case hobbies = "hobbies"
        case role = "role"
        case degree = "degree"
        case languages = "languages"
        case picture = "picture"
        case team = "team"
        case netid = "netid"
        case email = "email"
        case department = "department"
        case id = "id"
    }
    
    /// Use this in the case that we want to create an empty person.
    convenience init() {
        self.init(firstname: "", lastname: "", wherefrom: "", gender: "Male", hobbies: [], role: "Professor", degree: "", languages: [], picture: "", team: "", netid: "", email: "", department: "", id: "")
    }

    init(firstname: String, lastname: String, wherefrom: String, gender: String, hobbies: [String], role: String, degree: String, languages: [String], picture: String, team: String, netid: String, email: String, department: String, id: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.wherefrom = wherefrom
        self.gender = gender
        self.hobbies = hobbies
        self.role = role
        self.degree = degree
        self.languages = languages
        self.picture = picture
        self.team = team
        self.netid = netid
        self.email = email
        self.department = department
        self.id = id
    }
    
    // CustomStringConvertible protocol to display formatted content
    var description: String {
        
        let outputInfo = "My name is \(firstname) \(lastname) and I am from \(wherefrom). My best programming language(s): \(languages.joined(separator: ",")), and my favorite hobbies: \(hobbies.joined(separator: ",")). You can reach me at \(netid)@duke.edu."
        
        return (outputInfo)
    }
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
}
