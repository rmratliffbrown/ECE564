//
//  People+CoreDataClass.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/4/22.
//
//

import Foundation
import CoreData


public class People: NSManagedObject {
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
    
    required convenience public init(from decoder: Decoder) throws {
        // unchanged implementation
        self.init()
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstname, forKey: .firstname)
        try container.encode(lastname, forKey: .lastname)
        try container.encode(wherefrom, forKey: .wherefrom)
        try container.encode(gender, forKey: .gender)
        try container.encode(hobbies, forKey: .hobbies)
        try container.encode(role, forKey: .role)
        try container.encode(degree, forKey: .degree)
        try container.encode(languages, forKey: .languages)
        try container.encode(picture, forKey: .picture)
        try container.encode(team, forKey: .team)
        try container.encode(netid, forKey: .netid)
        try container.encode(email, forKey: .email)
        try container.encode(department, forKey: .department)
        try container.encode(id, forKey: .id)
    }

}
