//
//  Enums.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/19/22.
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
