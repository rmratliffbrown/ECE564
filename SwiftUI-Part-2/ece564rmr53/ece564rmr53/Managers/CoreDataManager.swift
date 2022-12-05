//
//  CoreDataManager.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/20/22.
//

import Foundation
import SwiftUI
import CoreData

enum Key: String {
    case dukePerson
}

/// This class is the only place in your project that should interact with Core Data.
class CoreDataManager {
    static var shared = CoreDataManager()
    
    var context: NSManagedObjectContext?
    let container: NSPersistentContainer
    
    // MARK: - Initializer
    private init() {
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Error loading Core Data \(error)")
            } else {
                print("Successfully loaded Core Data for cdModel!")
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            self.context = self.container.viewContext
        }
    }
    
    // MARK: - Fetch
    
    func fetchPeople() -> [DukePerson] {
        let fetchedPeople: [People] = fetchCoreDataPeople()
        let dukePeople: [DukePerson] = fetchedPeople.map { people in
            return DukePerson(firstname: people.firstname ?? "",
                              lastname: people.lastname ?? "",
                              wherefrom: people.wherefrom ?? "",
                              gender: people.gender ?? "",
                              hobbies: people.hobbies,
                              role: people.role ?? "",
                              degree: people.degree ?? "",
                              languages: people.languages,
                              picture: people.picture ?? "",
                              team: people.team ?? "",
                              netid: people.netid ?? "",
                              email: people.email ?? "",
                              department: people.department ?? "",
                              id: people.id ?? "",
                              refreshDate: people.refreshDate ?? Date())
        }
        return dukePeople
    }
    
    // I separated this part into a separate little helper function because I also have to call this code from the delete function.
    private func fetchCoreDataPeople() -> [People] {
        guard let context = context else {return []}
        do {
            let fetchedPeople: [People] = try context.fetch(People.fetchRequest())
            return fetchedPeople
        } catch let error {
            print("Error fetching. \(error)")
            return []
        }
    }
    
    // MARK: - Add
    
    func add(person: DukePerson){
        guard let context = context else {return}
        let tempPerson = People(context: context)
        tempPerson.firstname = person.firstname
        tempPerson.lastname = person.lastname
        tempPerson.wherefrom = person.wherefrom
        tempPerson.gender = person.gender
        tempPerson.hobbies = person.hobbies
        tempPerson.role = person.role
        tempPerson.degree = person.degree
        tempPerson.languages = person.languages
        tempPerson.picture = person.picture
        tempPerson.team = person.team
        tempPerson.netid = person.netid
        tempPerson.email = person.email
        tempPerson.department = person.department
        tempPerson.id = person.id
        tempPerson.refreshDate = person.refreshDate
        save()
    }
    
    func addAll(people: [DukePerson]) {
        people.forEach { person in
            add(person: person)
        }
        print("Done")
    }
    
    // MARK: - Delete
    
    func delete(person: DukePerson) {
        guard let context = context else {return}
        let fetchedPeople: [People] = fetchCoreDataPeople()
        guard let personToDelete: People = fetchedPeople.first(where: { $0.netid == person.netid }) else { return }
        context.delete(personToDelete)
        save()
        print("Delete Success")
    }
    
    func deleteALL() {
        guard let context = context else { return }
        let fetchedPeople: [People] = fetchCoreDataPeople()
        fetchedPeople.forEach { personToDelete in
            context.delete(personToDelete)
        }
        save()
        print("Delete all Success")
    }
    
    // MARK: - Edit
    
    func edit(person: DukePerson){
        delete(person: person)
        add(person: person)
    }
    
    // MARK: - Save
    
    private func save(){
        guard let context = context else {return}
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
