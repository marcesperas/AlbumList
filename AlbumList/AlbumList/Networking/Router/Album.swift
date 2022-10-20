//
//  Album.swift
//  AlbumList
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import Foundation

public extension API {
    enum Album: AppNetworkable {
        case fetchAlbums(request: AlbumRequest)
        case fetchImageData(urlString: String)
        
        public var request: URLRequest {
            switch self {
                case .fetchAlbums(let request):
                    return getRequest(with: Constants.Url.base + Constants.Url.albumPath, parameters: request.dictionary, httpMethod: .GET)
                case .fetchImageData(let urlString):
                    return getRequest(with: urlString, httpMethod: .GET)
            }
        }
    }
}
