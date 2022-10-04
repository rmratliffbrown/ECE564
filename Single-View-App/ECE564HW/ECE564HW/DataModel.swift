//
//  DukePerson.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/4/22.
//

import Foundation

// create a base class for Person
class Person {
    var fname: String = ""
    var lname: String = ""
    var from: String = ""
    var hobby: String = ""
    
}

// create a subclass for DukePerson
class DukePerson: Person, CustomStringConvertible {
    
    var netId: String = ""
    var progLang: String = ""
    
    // override the init for Person to add additional attributes to distinguish a DukePerson
    convenience init(_ fname: String, _ lname: String, _ from: String, _ hobby: String, _ NetId: String, _ ProgLang: String) {
        self.init()
        self.fname = fname
        self.lname = lname
        self.from = from
        self.hobby = hobby
        self.netId = NetId
        self.progLang = ProgLang

    }
    
    // CustomStringConvertible protocol to display formatted content
    var description: String {
        
        let outputInfo = "My name is \(fname) \(lname) and I am from \(from). My best programming language is \(progLang), and my favorite hobby is \(hobby). You can reach me at \(netId)@duke.edu"
        
        return (outputInfo)
    }

}
