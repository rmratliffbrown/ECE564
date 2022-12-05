import Foundation
import Combine

class NetworkManager {
    
    static var shared = NetworkManager()
    private init() {}
    
    func convertToBodyParams(params: [String: Any]) -> Data? {
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        return jsonData
    }
    
    func bindRequest(type: RequestItemType, params: [String: Any]) throws -> URLRequest {
        guard var components = URLComponents(string: type.url.absoluteString) else {
            throw CustomError(title: "Error!!", body: "Something went wrong, please try again.")
        }
        let queryParams: [URLQueryItem] = params.map { key, value in
            return URLQueryItem(name: key, value: "\(value)")
        }
        components.queryItems = queryParams.isEmpty ? nil : queryParams
        guard let url = components.url else {
            throw CustomError(title: "Error!!", body: "Something went wrong, please try again.")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.httpMethod
        let loginString = "rmr53:4704a3383210e8d3cca3147a11b82e3f593074044eb57ed7bb99127dee3b4344"
        guard let login = loginString.data(using: .utf8) else {
            throw CustomError(title: "Error!!", body: "Something went wrong, please try again.")
        }
        let converted = login.base64EncodedString()
        urlRequest.addValue("Basic \(converted)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    func bindCustomRequest(type: RequestItemType, params: [String: Any]) throws -> URLRequest {
        let postData = convertToBodyParams(params: params)
        var request = URLRequest(url: type.url, timeoutInterval: Double.infinity)
        request.httpMethod = type.httpMethod
        request.httpBody = postData
        let loginString = "rmr53:4704a3383210e8d3cca3147a11b82e3f593074044eb57ed7bb99127dee3b4344"
        guard let login = loginString.data(using: .utf8) else {
            throw CustomError(title: "Error!!", body: "Something went wrong, please try again.")
        }
        let converted = login.base64EncodedString()
        request.addValue("Basic \(converted)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func callAPI<T: Codable>(type: RequestItemType, params: [String: Any]?, isUseCustomBodyParam: Bool = false) -> AnyPublisher<T, Error> {
        do {
            let request = try isUseCustomBodyParam ? bindCustomRequest(type: type, params: params ?? [:]): bindRequest(type: type, params: params ?? [:])
            return URLSession.shared
                .dataTaskPublisher(for: request)
                .mapError {$0 as Error}
                .tryMap { result in
                    guard result.response is HTTPURLResponse else {
                        throw CustomError(title: "Response Error", body: "")
                    }
                    do {
                        if let httpResponse = result.response as? HTTPURLResponse {
                                print("statusCode: \(httpResponse.statusCode)")
                            }
                        let value = try JSONDecoder().decode(T.self, from: result.data)
                        return value
                    } catch {
                        throw CustomError(title: "Decoding Error", body: error.localizedDescription)
                    }
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}
