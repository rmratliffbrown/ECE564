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
            printPeople()
            print("OIJSDFOIJSFOISJFIOSF")
            let success = JSONManager.shared.saveToJSON(people)
            print("Saved: \(success)")
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
            print("\(person.firstname): \(person.netid), department: \(person.department)")
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
        print("Department: \(person.department)")
        
        // set 'i' to the index of where the person.netid matches the input netid
        if let i = people.firstIndex(where: { $0.netid == person.netid }) {
            
            // This block runs only if i is saved to a value. If firstIndex() returns nil, then this is skipped.
            people[i] = person
            
            if people[i].firstname == "Rashaad" && people[i].lastname == "Ratliff-Brown" {
                makePOSTRequest(dukePerson: people[i])
            }
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
    
//    4704a3383210e8d3cca3147a11b82e3f593074044eb57ed7bb99127dee3b4344
    
    func makePUTRequest(dukePerson: DukePerson) {
        print("Put: \(dukePerson.netid)")
        guard let url = URL(string:"https://ece564server-vapor.colab.duke.edu/entries/\(dukePerson.netid)") else { return }
        
        let jsonDict = [
            "id": dukePerson.id as Any,
            "netid": dukePerson.netid as Any,
            "firstname": dukePerson.firstname as Any,
            "lastname": dukePerson.lastname as Any,
            "wherefrom": dukePerson.wherefrom as Any,
            "gender": dukePerson.gender as Any,
            "role": dukePerson.role as Any,
            "degree": dukePerson.degree as Any,
            "team": dukePerson.team as Any,
            "hobbies": dukePerson.hobbies as Any,
            "languages": dukePerson.languages as Any,
            "department": dukePerson.department as Any,
            "email": dukePerson.email as Any,
            "picture": dukePerson.picture as Any,
        ] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.httpBody = jsonData
        let loginString = "rmr53:4704a3383210e8d3cca3147a11b82e3f593074044eb57ed7bb99127dee3b4344"
        print(dukePerson.netid)
        guard let login = loginString.data(using: .utf8) else {return}
        let converted = login.base64EncodedString()
        urlRequest.setValue("Basic \(converted)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let httprequest = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("error calling PUT on /posts/: \(String(describing: error))")
                return
            }
            guard let data = data else { return }
            print(data)
            print(response!)
            do {
                //_ = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]

            } catch let error {
                print("json error: \(error)")
            }
        }
        httprequest.resume()
    }
    

    func makePOSTRequest(dukePerson: DukePerson) {
        print("Posting Rashaad")
        guard let url = URL(string:"https://ece564server-vapor.colab.duke.edu/entries/create") else { return }
        
        let jsonDict = [
            "id": dukePerson.id as Any,
            "netid": dukePerson.netid as Any,
            "firstname": dukePerson.firstname as Any,
            "lastname": dukePerson.lastname as Any,
            "wherefrom": dukePerson.wherefrom as Any,
            "gender": dukePerson.gender as Any,
            "role": dukePerson.role as Any,
            "degree": dukePerson.degree as Any,
            "team": dukePerson.team as Any,
            "hobbies": dukePerson.hobbies as Any,
            "languages": dukePerson.languages as Any,
            "department": dukePerson.department as Any,
            "email": dukePerson.email as Any,
            "picture": dukePerson.picture as Any,
        ] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDict, options: [])
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        let loginString = "rmr53:4704a3383210e8d3cca3147a11b82e3f593074044eb57ed7bb99127dee3b4344"
        print(dukePerson.netid)
        guard let login = loginString.data(using: .utf8) else {return}
        let converted = login.base64EncodedString()
        urlRequest.setValue("Basic \(converted)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let httprequest = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("error calling POST on /posts/: \(String(describing: error))")
                return
            }
            guard let data = data else { return }
            print(data)
            print(response!)
            do {
                //_ = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]

            } catch let error {
                print("json error: \(error)")
            }
        }
        httprequest.resume()
    }

    func makeGetRequest(completion: @escaping (_ people: [DukePerson]?) -> Void) {
        guard let url = URL(string: "https://ece564server-vapor.colab.duke.edu/entries/all") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let loginString = "rmr53:4704a3383210e8d3cca3147a11b82e3f593074044eb57ed7bb99127dee3b4344"
        guard let login = loginString.data(using: .utf8) else {return}
        let converted = login.base64EncodedString()
        urlRequest.setValue("Basic \(converted)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print("error calling GET on /posts/: \(String(describing: error))")
                return
            }
            guard let data = data else { return }
            print(data)
            print(response as Any)
            do {
                // Converts the data retrieved from the remote server into a Swift object that we can worrk with (like the [DukePerson])
                print("HEreee")
                let people = try JSONDecoder().decode([DukePerson].self, from: data)
//                let people = try JSONSerialization.jsonObject(with: data, options: []) as! [DukePerson]
                print("And here")
                completion(people)
            } catch let error {
                print("json error: \(error)")
                completion(nil)
            }
        }
        dataTask.resume()

    }
    
//    func convertToJSON(_ sender: Any) -> Data? {
//        do {
//            let data = try JSONSerialization.data(withJSONObject: sender, options: JSONSerialization.WritingOptions.prettyPrinted)
//            return data
//        } catch let error {
//            print("json error: \(error)")
//            return nil
//        }
//    }
    
    func convertToJSON(_ dukePerson: DukePerson) -> Data? {
        do {
            let encodedData = try JSONEncoder().encode(dukePerson)
            return encodedData
        } catch let error {
            print("JSON error: \(error)")
            return nil
        }
    }
}
