//
//  AlbumListViewController.swift
//  AlbumList
//
//  Created by Marc Jardine Esperas on 10/18/22.
//

import UIKit

class AlbumListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: AlbumListViewModelProtocol = AlbumListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchAlbumList()
    }

    private func fetchAlbumList() {
        ActivityIndicator.start(for: view)
        viewModel.fetchAlbums { [weak self] result in
            switch result {
                case .success():
                    self?.collectionView.reloadData()
                case .failure(let error):
                    self?.showAlert(message: error.description)
            }
            ActivityIndicator.stop()
        }
    }
    
    private func fetchImageData(row: Int, completion: @escaping (UIImage?) -> ()) {
        let urlString = viewModel.album(at: row).primaryRelease.image
        viewModel.fetchImageData(with: urlString) { result in
            if case let .success(data) = result {
                completion(UIImage(data: data))
            } else {
                completion(UIImage(named: "ImageNotAvailable"))
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension AlbumListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "imageCell"
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError("ImageCollectionViewCell not found")
        }
    
        fetchImageData(row: indexPath.row) { image in
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }

        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension AlbumListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace - 0) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
}
