import Foundation

class CustomError: Error, LocalizedError {
    var title: String = ""
    var body: String = ""
    
    var errorDescription: String? {
        return body
    }
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
}
