//
//  AlbumListViewModelTests.swift
//  AlbumListTests
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import XCTest

@testable import AlbumList

final class AlbumListViewModelTests: XCTestCase {
    private var dataProviderMock: AlbumDataProviderMock!
    private var sut: AlbumListViewModelProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        dataProviderMock = AlbumDataProviderMock()
        sut = AlbumListViewModel(dataProvider: dataProviderMock)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        dataProviderMock = nil
        sut = nil
    }
    
    func testAlbumListViewModel_ShouldCallFetchAlbums() {
        let expectation = self.expectation(description: "Call fetchAlbums() method")
        
        sut.fetchAlbums { _ in
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
        XCTAssertTrue(dataProviderMock.isfetchAlbumsMethodCalled)
    }
    
    func testAlbumListViewModel_ShouldCallFetchImageData() {
        let expectation = self.expectation(description: "Call fetchImageData() method")
        
        sut.fetchImageData(with: "https://d16npyvi7pcxgr.cloudfront.net/images1004/100/4_0/060/255/773/428/7/104_1004_00602557734287_20220222_0241.jpg") { _ in
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
        XCTAssertTrue(dataProviderMock.isfetchImageDataMethodCalled)
    }

}
