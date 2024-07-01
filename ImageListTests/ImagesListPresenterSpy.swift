//
//  ImagesListPresenterSpy.swift
//  ImageListTests
//
//  Created by Мария Шагина on 26.06.2024.
//

@testable import ImageFeed
import Foundation

final class ImagesListPresenterSpy: ImagesListPresenterProtocol {
    var imagesListService: ImageFeed.ImagesListServiceProtocol
    
    init(imagesListService: ImagesListServiceProtocol = ImagesListServiceStub()) {
            self.imagesListService = imagesListService
        }
    
    var view: ImagesListViewControllerProtocol?
    var photos: [Photo] = []
    
    var viewDidLoadCalled = false
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    func setupLike(cell: ImageFeed.ImagesListCell, row: Int) { }
}
