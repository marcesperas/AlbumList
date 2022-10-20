//
//  AppNetworkable.swift
//  AlbumList
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import Foundation

public enum RequestType : String {
    /// HTTP GET request
    case GET
    /// HTTP POST request
    case POST
}

public protocol AppNetworkable {
    /// `URLRequest` of the request.
    var request: URLRequest { get }
}

public extension AppNetworkable {
    func getRequest(with path: String, parameters: [String: Any]?, httpMethod: RequestType) -> URLRequest {
        
        guard var components = URLComponents(url: URL(string: path)!, resolvingAgainstBaseURL: true) else {
            return URLRequest(url: URL(string:path)!)
        }

        components.queryItems = parameters?.map({ (key, value) in
            URLQueryItem(name: key, value: String(describing: value))
        })

        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        let request = getRequest(with: components.url!.absoluteString, httpMethod: httpMethod)
        
        return request
    }
    
    func getRequest(with path: String, httpMethod: RequestType) -> URLRequest {
        var request = URLRequest(url: URL(string:path)!)
        
        request.httpMethod = httpMethod.rawValue
        
        API.getHeaders().forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return request
    }
    
    func fetchResponse<V: Decodable>(completion: @escaping ((Result<V, NetworkError>) -> Void)) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.unableToCompleteRequest))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                guard V.self != Data.self else {
                    completion(.success(data as! V))
                    print("The response is: ", data)
                    return
                }
                
                print("The response is: ", String(data: data, encoding: .utf8)!)
                
                do {
                    let result = try JSONDecoder().decode(V.self, from: data)
                    completion(.success(result))
                    
                } catch let error {
                    print("JSON Decode Error: \(error)")
                    completion(.failure(.jsonDecodingError))
                }
            }
        }
        
        task.resume()
    }
}

