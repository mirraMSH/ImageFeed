//
//  ImageListPresenter.swift
//  ImageFeed
//
//  Created by Мария Шагина on 25.06.2024.
//

import UIKit


protocol ImagesListPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get set }
    var photos: [Photo] { get set }
    func viewDidLoad()
    var imagesListService: ImagesListServiceProtocol { get }
    func setupLike(cell: ImagesListCell, row: Int)
}

final class ImagesListPresenter: ImagesListPresenterProtocol {
    
    
    // MARK: - Public Properties
    weak var view: ImagesListViewControllerProtocol?
    var photos: [Photo] = []
    internal var imagesListService: ImagesListServiceProtocol
    init(imagesListService: ImagesListServiceProtocol = ImagesListService.shared) {
            self.imagesListService = imagesListService
        }
    // MARK: - Private Properties
    private var imagesListServiceObserver: NSObjectProtocol?
   
    // MARK: - Public Methods
    func viewDidLoad() {
        imagesListServiceObserver = NotificationCenter.default.addObserver(
            forName: ImagesListService.didChangeNotification,
            object: nil,
            queue: .main) { [weak self] _ in
                guard let self = self else { return }
                view?.updateTableViewAnimated()
            }
        imagesListService.fetchPhotosNextPage(completion: { _ in })
    }
    
    func setupLike(cell: ImagesListCell, row: Int) {
        let photo = photos[row]
        UIBlockingProgressHUD.show()
        imagesListService.changeLike(photoId: photo.id, isLiked: !photo.isLiked) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.photos = self.imagesListService.photos
                cell.setIsLiked(isLiked: self.photos[row].isLiked)
                UIBlockingProgressHUD.dismiss()
            case .failure:
                UIBlockingProgressHUD.dismiss()
                self.showAlert()
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "Что-то пошло не так",
            message: "Не удалось поставить лайк",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "ОК", style: .default ) { _ in
            alert.dismiss(animated: true)
        }
    }
}

