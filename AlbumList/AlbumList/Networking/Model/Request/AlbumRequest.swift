//
//  AlbumRequest.swift
//  AlbumList
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import Foundation

// MARK: - AlbumRequest
public struct AlbumRequest: Encodable {
    public let offset: String
    public let count: String
    
    public init(offset: String = "1", count: String = "10") {
        self.offset = offset
        self.count = count
    }
}
