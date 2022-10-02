//
//  DukePerson.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/4/22.
//

import Foundation

// create a base class for Person
class Person {
    var firstname: String = ""
    var lastname: String = ""
    var wherefrom: String = ""
    var gender: String = ""
    var hobbies: [String] = []
    var picture: String = ""
    var id: String = ""
}

// create a subclass for DukePerson
class DukePerson: Person, CustomStringConvertible, Codable {
    
    //static let documentsDir = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
    //static let archiveURL = documentsDir.appendingPathComponent("peopleFile")
    
    //let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    //let ArchiveURL = DocumentsDirectory.appendingPathComponent("ECE564Cohort.json")
    
    var netid: String = ""
    var role: String = ""
    var languages = [String]()
    var department = ""
    var degree: String = ""
    var team: String = ""
    var email: String = ""
    
    
    // override the init for Person to add additional attributes to distinguish a DukePerson
    convenience init(_ firstname: String, _ lastname: String, _ wherefrom: String, _ gender: String, _ hobbies: [String],
                     _ role: String, _ degree: String, _ languages: [String], _ picture: String, _ team: String, _ netid: String,
                     _ email: String, _ department: String, _ id: String) {
        self.init()
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
        
        let outputInfo = "My name is \(firstname) \(lastname) and I am from \(wherefrom). My best programming language(s): \(languages.joined(separator: ",")), and my favorite hobbies: \(hobbies.joined(separator: ", ")). You can reach me at \(netid)@duke.edu."
        
        return (outputInfo)
    }
    
    //static let allPeople: [DukePerson] = Bundle.main.decode(file: "ECE564Cohort.json")
    
//    func loadJSON() -> [DukePerson]{
//        var people = [DukePerson]()
//        //var _: [DukePersonElement] = {
//        let decoder = JSONDecoder()
//        let data: Data
//
//        do {
//            data = try Data(contentsOf: DukePerson.archiveURL)
//        } catch {
//            print(error.localizedDescription)
//            return []
//        }
//        if let elements = try? decoder.decode([DukePerson].self, from: data){
//            print(elements)
//            people = elements
//
//        }
//
//        return people
//    }
//        //}
////    }()
//
//    func saveToJSON(_ items: [DukePerson]) -> Bool {
//        //let ArchiveURL = DocumentsDirectory.appendingPathComponent("ECE564Cohort.json")
//        var outputData = Data()
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(items) {
//            if let json = String(data: encoded, encoding: .utf8) {
//                //print(json)
//                outputData = encoded
//                print("saveToJSON outputdata: \(outputData)")
//            }
//            else { return false }
//
//            do {
//                try outputData.write(to: DukePersonElement.archiveURL)
//
//            } catch let error as NSError {
//                print (error)
//                return false
//            }
//            return true
//        }
//        else { return false }
//    }


}








