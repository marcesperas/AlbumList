//
//  AlbumResponse.swift
//  AlbumList
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import Foundation

// MARK: - AlbumResponse
struct AlbumResponse: Codable {
    let offset, count, total: Int
    let albumList: [Album]

    enum CodingKeys: String, CodingKey {
        case offset = "Offset"
        case count = "Count"
        case total = "Total"
        case albumList = "Results"
    }
}

// MARK: - Result
struct Album: Codable {
    let primaryRelease: PrimaryRelease

    enum CodingKeys: String, CodingKey {
        case primaryRelease = "PrimaryRelease"
    }
}

// MARK: - PrimaryRelease
struct PrimaryRelease: Codable {
    let image: String

    enum CodingKeys: String, CodingKey {
        case image = "Image"
    }
}
