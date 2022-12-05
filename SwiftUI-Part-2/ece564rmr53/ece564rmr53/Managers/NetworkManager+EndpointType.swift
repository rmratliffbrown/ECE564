import Foundation

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var url: URL { get }
    var param: [String: Any]? { get }
    var httpMethod: String { get }
}
