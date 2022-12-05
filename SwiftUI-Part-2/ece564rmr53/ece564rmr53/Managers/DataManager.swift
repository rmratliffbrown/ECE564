//
//  DataManager.swift
//  ece564rmr53
//
// Created by Rashaad Ratliff-Brown on 10/20/22.
//

import SwiftUI
import Combine

/// This class is the "single source of truth" for your data.

/// For fetching/saving data, your views should ONLY interact with this class (not any of the other data manager classes). This class will interact with the other data managers as appropriate.
class DataManager: ObservableObject {
    static var shared = DataManager()
    
    private let myNetId: String = ""
    @Published var isLoading: Bool = false
    @Published var people: [DukePerson] = []
    @Published var filteredPeople: [DukePerson] = []
    @Published var peopleListData: [DukeListModel] = []
    
    @Published var searchQuery: String = ""
    @Published var lastDataUpdate: Date = Date()
    private var dataCancellable = Set<AnyCancellable>()
    var cancallable: AnyCancellable? = nil
    
    /// This initializer fetches our initial data from the appropriate spot.
    private init() {
        
        // Fetch intial data from Core Data.
        self.people = CoreDataManager.shared.fetchPeople()
        
        // If the people array is empty, we know we didn't have anything saved in Core Data, so we need to fetch the initial data from our JSON file instead.
        if self.people.isEmpty {
            self.people = JSONManager.shared.loadData()
            CoreDataManager.shared.addAll(people: self.people)
        }
        self.people = self.people.map { person in
            let person = person
            if person.id.isEmpty {
                person.id = UUID().uuidString
            }
            return person
        }
        self.filteredPeople = people
        
        self.setupListData(persons: filteredPeople)
        setupSearchResponser()
    }
    
    func setupSearchResponser() {
        cancallable = $searchQuery
            .removeDuplicates()
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] query in
                guard let `self` = self else { return }
                
                if query.isEmpty {
                    self.filteredPeople = self.people
                } else {
                    let matchingPeople = self.people.filter({ $0.contains(searchText: query) })
                    self.filteredPeople = matchingPeople
                }
                self.setupListData(persons: self.filteredPeople)
            })
    }
    
    // Below are methods to manipulate data. Call these from your views.
    
    // MARK: Add
    
    func add(person: DukePerson) {
        
        // Update local data array
        self.people.append(person)
        self.filteredPeople.append(person)
        self.setupListData(persons: filteredPeople)
        
        // Update core data
        CoreDataManager.shared.add(person: person)
    }
    
    // MARK: Remove
    
    func remove(person: DukePerson) {
        // Remove from local data array
        self.people.removeAll { $0.netid == person.netid }
        self.filteredPeople.removeAll { $0.netid == person.netid }
        self.setupListData(persons: filteredPeople)
        
        // Remove from core data
        CoreDataManager.shared.delete(person: person)
    }
    
    // MARK: Edit
    
    func updatePerson(person: DukePerson, isUpdateOnServer: Bool = false) {
        
        // Edit local data array
        guard let index = self.people.firstIndex(where: { $0.netid == person.netid }) else { return }
        self.people[index] = person
        self.filteredPeople[index] = person
        
        self.setupListData(persons: filteredPeople)
        // Update core data
        CoreDataManager.shared.edit(person: person)
        if let i = people.firstIndex(where: { $0.netid == person.netid }) {
            
            // This block runs only if i is saved to a value. If firstIndex() returns nil, then this is skipped.
            people[i] = person
            
            if people[i].firstname == "Rashaad" && people[i].lastname == "Ratliff-Brown" {
                makePOSTRequest(dukePerson: person)
            }
        }
    }
    
    func makeGetRequest(completion: @escaping (_ people: DukePerson?) -> Void) {
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
                // Converts the data retrieved from the remote server into a Swift object that we can work with (like the [DukePerson])
                print("HEreee")
                let person = try JSONDecoder().decode(DukePerson.self, from: data)
//                let people = try JSONSerialization.jsonObject(with: data, options: []) as! [DukePerson]
                print("And here")
                completion(person)
            } catch let error {
                print("json error: \(error)")
                completion(nil)
            }
        }
        dataTask.resume()

    }
    
    func makePOSTRequest(dukePerson: DukePerson) {
        print("Posting Rashaad")
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
                print("error calling POST on /posts/: \(String(describing: error))")
                return
            }
            guard let data = data else { return }
            print(data)
            print(response!)
        }
        httprequest.resume()
    }

    
    private func getData() -> AnyPublisher<[DukePerson], Error> {
        return NetworkManager.shared.callAPI(type: .getAllEntriesList, params: nil)
    }
    
    
    
    
    
    // MARK: - Networking Methods.
    func refreshData() {
        isLoading = true
        // Fetch data from server
        getData()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                guard let `self` = self else {
                    return
                }
                self.isLoading = false
                switch completion {
                case .finished:
                    debugPrint("success")
                case .failure(_):
                    debugPrint("failed")
                }
            } receiveValue: { [weak self] people in
                guard let `self` = self else { return }
                print(people)
                // Update data array
                DispatchQueue.main.async {
                    self.people = people
                    self.people = self.people.map { person in
                        let person = person
                        person.refreshDate = Date()
                        return person
                    }
                    self.filteredPeople = self.people
                    self.setupListData(persons: self.filteredPeople)
                    
                    // Update core data
                    CoreDataManager.shared.deleteALL()
                    CoreDataManager.shared.addAll(people: self.filteredPeople)
                }
            }
            .store(in: &dataCancellable)
    }
    
    func getLastUpdateTime() -> String {
        if let date = self.filteredPeople.first?.refreshDate {
            return "Updated \(date.timeAgoDisplay())"
        } else {
            return "Updated"
        }
    }
    
    func setupListData(persons: [DukePerson]) {
        var dukeListData: [DukeListModel] = []
        for role in Role.allCases {
            let filter = persons.filter {$0.role == role.rawValue}
            var dukeList = DukeListModel()
            dukeList.role = role.rawValue
            
            var teams: [String: [DukePerson]] = [:]
            for person in filter {
                if teams[person.team] != nil {
                    teams[person.team]?.append(person)
                } else {
                    teams[person.team] = [person]
                }
            }
            
            for team in teams {
                let dukeTeam = DukeTeams(teamName: team.key, teams: team.value)
                dukeList.dukeTeams.append(dukeTeam)
            }
            
            dukeListData.append(dukeList)
        }
        self.peopleListData = dukeListData
    }
    
}
