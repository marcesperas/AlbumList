//
//  Constants.swift
//  AlbumList
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import Foundation

struct Constants {
    struct Url {
        static let base: String = "https://api-metadata-connect.tunedglobal.com"
        static let albumPath: String = "/api/v2.1/albums/trending"
    }
    
    struct Header {
        static let storeId: String = "luJdnSN3muj1Wf1Q"
    }
}

extension Constants {
    struct StoryboardName {
        static let albumList = "AlbumList"
    }
}
