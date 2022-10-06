//
//  People+CoreDataProperties.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/4/22.
//
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "Person")
    }

    @NSManaged public var degree: String?
    @NSManaged public var department: String?
    @NSManaged public var email: String?
    @NSManaged public var firstname: String?
    @NSManaged public var gender: String?
    @NSManaged public var hobby: String
    @NSManaged public var id: String?
    @NSManaged public var language: String
    @NSManaged public var lastname: String?
    @NSManaged public var netid: String?
    @NSManaged public var picture: String?
    @NSManaged public var role: String?
    @NSManaged public var team: String?
    @NSManaged public var wherefrom: String?
    
    // Computed values to handle storing an array of String objects
    
    var hobbies : [String] {
        get { decodeArray(from: \.hobby) }
        set { hobby = encodeArray(newValue) }
    }
    
    var languages : [String] {
        get { decodeArray(from: \.language) }
        set { language = encodeArray(newValue) }
    }
    
    private func decodeArray(from keyPath: KeyPath<People,String>) -> [String] {
        return (try? JSONDecoder().decode([String].self, from: Data(self[keyPath: keyPath].utf8))) ?? []
    }
    
    private func encodeArray(_ array: [String]) -> String {
        guard let data = try? JSONEncoder().encode(array) else { return "" }
        return String(data: data, encoding: .utf8)!
    }

}

extension People : Identifiable {

}
