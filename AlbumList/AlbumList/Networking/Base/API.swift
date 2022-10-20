//
//  API.swift
//  AlbumList
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import Foundation

public enum API {
    static func getHeaders() -> [String: String] {
        return ["StoreId": Constants.Header.storeId]
    }
}
