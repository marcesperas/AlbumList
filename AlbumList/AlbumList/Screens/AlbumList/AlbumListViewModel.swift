//
//  AlbumListViewModel.swift
//  AlbumList
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import Foundation

protocol AlbumListViewModelProtocol {
    func numberOfItems(in section: Int) -> Int
    func album(at index: Int) -> Album
    func fetchAlbums(completion: @escaping (Result<Void, NetworkError>) -> Void)
    func fetchImageData(with urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class AlbumListViewModel: AlbumListViewModelProtocol {
    private let dataProvider: AlbumDataProviderProtocol
    private var AlbumList: [Album] = []
    
    init(dataProvider: AlbumDataProviderProtocol = AlbumDataProvider()) {
        self.dataProvider = dataProvider
    }
    
    func numberOfItems(in section: Int) -> Int {
        return AlbumList.count
    }
    
    func album(at index: Int) -> Album {
        return AlbumList[index]
    }
    
    func fetchAlbums(completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let request = AlbumRequest()
        
        dataProvider.fetchAlbums(request: request) { [weak self] result in
            switch result {
                case .success(let response):
                    self?.AlbumList = response.albumList
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func fetchImageData(with urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        dataProvider.fetchImageData(urlString: urlString) { result in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
