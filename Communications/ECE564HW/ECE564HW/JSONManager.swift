import Foundation

// interacts with the database
class JSONManager {
    static var shared: JSONManager = JSONManager()
    
    private let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    lazy private var ArchiveURL = DocumentsDirectory.appendingPathComponent("in-phone-memory-saved-file")
    
    private init() {}
    
    /// Load original/starting JSON data from ECE564Cohort.json file.
    func loadOriginalJSON() -> [DukePerson]? {
        if let url = Bundle.main.url(forResource: "ECE564Cohort", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            do {
                let people = try decoder.decode([DukePerson].self, from: data)
                return people
            }
            catch {
                print(error)
                return nil
            }
        }
        return nil
    }
    
    /// Loads the new JSON saved in the app's Documents Directory.
    func loadNewJSON() -> [DukePerson]{
        do {
            let data = try Data(contentsOf: ArchiveURL)
            let decoder = JSONDecoder()
            let elements = try decoder.decode([DukePerson].self, from: data)
            return elements
        } catch {
            print(error)
            return []
        }
    }
    
    func saveToJSON(_ items: [DukePerson]) -> Bool {
        
        var outputData = Data()
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            if String(data: encoded, encoding: .utf8) != nil {
                //print(json)
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
    
}
