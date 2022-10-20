//
//  AlbumListTests.swift
//  AlbumListTests
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import XCTest
@testable import AlbumList

final class AlbumListTests: XCTestCase {
    var sut: AlbumDataProviderProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = AlbumDataProvider()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }

    func testFetchAlbums_ShouldReturnSuccess() {
        let request: AlbumRequest = AlbumRequest()
        
        let expectation = self.expectation(description: "fetchAlbums Service")
        
        sut.fetchAlbums(request: request) { result in
            if case .success(let response) = result {
                XCTAssertNotNil(response)
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 30)
    }
    
    func testFetchImageData_ShouldReturnSuccess() {
        let urlString: String = "https://d16npyvi7pcxgr.cloudfront.net/images1004/100/4_0/060/249/834/122/3/104_1004_00602498341223_20210225_1848.jpg"
        
        let expectation = self.expectation(description: "fetchImageData Service")
        
        sut.fetchImageData(urlString: urlString) { result in
            if case .success(let response) = result {
                XCTAssertNotNil(response)
                expectation.fulfill()
            }
        }
        
        self.wait(for: [expectation], timeout: 30)
    }
}
