import Foundation

struct DukePersonElement: Codable, CustomStringConvertible {
    var firstname, lastname, wherefrom, gender: String
    var hobbies: [String]
    var role, degree: String
    var languages: [String]
    var picture, team, netid, email: String
    var department, id: String
    
    var description: String {
        
        let outputInfo = "My name is \(firstname) \(lastname) and I am a \(role) at Duke University. I am from \(wherefrom). My best programming language(s): \(languages.joined(separator: ", ")), and my favorite hobbies: \(hobbies.joined(separator: ", ")). You can reach me at \(netid)@duke.edu."
        
        return (outputInfo)
    }
    
    //init(from decoder: Decoder) throws { }
    //required init(from decoder: Decoder) throws { }
    //func encode(to encoder: Encoder) throws { }
    
    init(_ firstname: String, _ lastname: String, _ wherefrom: String, _ gender: String, _ hobbies: [String],
                     _ role: String, _ degree: String, _ languages: [String], _ picture: String, _ team: String, _ netid: String,
         _ email: String, _ department: String, _ id: String) {
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
        
        //var allPeople: [DukePersonElement] = Bundle.main.decode(file: "ECE564Cohort.json")
        //var _: DukePersonElement = allPeople[8]
        

    }

}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("File \(file) not found in project")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("File \(file) not found in project")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("File \(file) not found in project")
        }
        
        return loadedData
    }
}

// gender enum
enum Gender: String, CaseIterable, CustomStringConvertible{
    case Male, Female, Other, Unknown
    
    var description: String {
      rawValue
    }
}

let genders = Gender.allCases

// role enum
enum Role: String, CaseIterable, CustomStringConvertible{
    case Professor, TA, Student, Other
    
    var description: String{
        rawValue
    }

}

let roles = Role.allCases

// take look at load function
func loadJSON() -> [DukePersonElement]{
//        var _: [DukePersonElement] = {
        do {
//                let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//                    .appendingPathComponent("ECE564Cohort.json")

            let data = try Data(contentsOf: ArchiveURL)
            let decoder = JSONDecoder()
            let elements = try decoder.decode([DukePersonElement].self, from: data)
            return elements
        } catch {
            print(error.localizedDescription)
            return []
        }
}

func saveToJSON(_ items: [DukePersonElement]) -> Bool {
    
    var outputData = Data()
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(items) {
        if let json = String(data: encoded, encoding: .utf8) {
            print(json)
            outputData = encoded
        }
        else { return false }
        
        do {
                try outputData.write(to: ArchiveURL)
        } catch let error as NSError {
            print (error)
            return false
        }
        return true
    }
    else { return false }
}
