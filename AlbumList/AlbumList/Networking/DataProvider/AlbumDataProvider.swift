//
//  AlbumDataProvider.swift
//  AlbumList
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import Foundation

protocol AlbumDataProviderProtocol: AnyObject {
    func fetchAlbums(request: AlbumRequest, completion: @escaping (Result<AlbumResponse, NetworkError>) -> Void)
    func fetchImageData(urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

public class AlbumDataProvider: AlbumDataProviderProtocol {
    public init() {}
    
    func fetchAlbums(request: AlbumRequest, completion: @escaping (Result<AlbumResponse, NetworkError>) -> Void) {
        API.Album.fetchAlbums(request: request).fetchResponse(completion: completion)
    }
    
    func fetchImageData(urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        API.Album.fetchImageData(urlString: urlString).fetchResponse(completion: completion)
    }
}
