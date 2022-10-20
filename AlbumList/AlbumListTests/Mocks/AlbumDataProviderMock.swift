//
//  AlbumDataProviderMock.swift
//  AlbumListTests
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import Foundation

@testable import AlbumList

class AlbumDataProviderMock: AlbumDataProviderProtocol {
    var shouldReturnError: Bool = false
    var isfetchAlbumsMethodCalled: Bool = false
    var isfetchImageDataMethodCalled: Bool = false
    
    func fetchAlbums(request: AlbumList.AlbumRequest, completion: @escaping (Result<AlbumResponse, NetworkError>) -> Void) {
        guard !shouldReturnError else {
            completion(.failure(.invalidUrl))
            return
        }
        
        StubData.read(file: "Login", completion: completion)
        isfetchAlbumsMethodCalled = true
    }
    
    func fetchImageData(urlString: String, completion: @escaping (Result<Data, AlbumList.NetworkError>) -> Void) {
        guard !shouldReturnError else {
            completion(.failure(.invalidUrl))
            return
        }
        
        StubData.imageData(completion: completion)
        isfetchImageDataMethodCalled = true
    }
}
