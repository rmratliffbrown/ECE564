import Foundation

enum RequestItemType {
    case getAllEntriesList
    case updateData(netid: String)
    case createUpdateData
    case getEntriesID(netid: String)
}

extension RequestItemType: EndPointType {
    
    var baseURL: String {
        return "https://ece564server-vapor.colab.duke.edu/"
    }

    var path: String {
        switch self {
        case .getAllEntriesList:
            return "entries/all"
        case .updateData(let netid):
            return "entries/\(netid)"
        case .createUpdateData:
            return "entries/create"
        case .getEntriesID(let netid):
            return "entries/\(netid)"
        }
    }

    var url: URL {
        return URL(string: baseURL + path)!
    }
    
    var param: [String : Any]? {
        return nil
    }
    
    var httpMethod: String {
        switch self {
        case .createUpdateData:
            return "POST"
        case .updateData:
            return "PUT"
        default:
            return "GET"
        }
    }
    
}
