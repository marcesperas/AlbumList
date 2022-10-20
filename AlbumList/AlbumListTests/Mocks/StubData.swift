//
//  StubData.swift
//  AlbumListTests
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import UIKit

@testable import AlbumList
import UIKit

struct StubData {
    static func read<V: Decodable>(file: String, completion: @escaping (Result<V, NetworkError>) -> Void) {
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONDecoder().decode(V.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.invalidResponse))
            }
        } else {
            completion(.failure(.invalidData))
        }
    }
    
    static func imageData(completion: (Result<Data, NetworkError>) -> Void) {
        let url = URL(string: "https://d16npyvi7pcxgr.cloudfront.net/images1004/100/4_0/060/255/773/428/7/104_1004_00602557734287_20220222_0241.jpg")!
        do {
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch {
            completion(.failure(.invalidData))
        }
    }
}
