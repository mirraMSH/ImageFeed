//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Мария Шагина on 08.06.2024.
//

import Foundation


struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
    
    init(result photo: PhotoResult) {
        self.id = photo.id
        self.size = CGSize(width: photo.width, height: photo.height)
        self.createdAt = ISO8601DateFormatter().date(from: photo.createdAt ?? "")
        self.welcomeDescription = photo.description
        self.thumbImageURL = photo.urls?.thumbImageURL ?? ""
        self.largeImageURL = photo.urls?.largeImageURL ?? ""
        self.isLiked = photo.likedByUser
    }
}

struct PhotoResult: Codable {
    let id: String
    let width: CGFloat
    let height: CGFloat
    let createdAt: String?
    let description: String?
    var likedByUser: Bool
    let urls: UrlsResult?
}

struct UrlsResult: Codable {
    let largeImageURL: String?
    let thumbImageURL: String?
    
}

final class ImagesListService {
    static let shared = ImagesListService()
    private init() { }
    
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    private (set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    private let perPage: Int = 10
    private var nextPage: Int = 0
    private var pageNumber: Int = 1
    private let oAuthTokenStorage = OAuth2TokenStorage()
    
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    
    func fetchPhotosNextPage(completion: @escaping (Result<[Photo], Error>) -> Void) {
        assert(Thread.isMainThread)
        if task != nil { return }
        task?.cancel()
        
        guard var request = URLRequest.makeHTTPRequest(path: "/photos", httpMethod: "GET", baseURL: Constants.defaultBaseURL),
              //        (path: "/photos?page=\(nextPage)&&per_page=\(perPage)", httpMethod: "GET", ),
              let token = oAuthTokenStorage.token else {
            assertionFailure("Failed to make HTTP request in ImageListService URL Method")
            return
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = urlSession.objectTask(for: request) { [weak self] (result:Result<[PhotoResult], Error>) in
            guard let self = self else { return }
            self.task = nil
            
            switch result {
            case .success(let photoResults):
                self.photos.append(contentsOf: photoResults.map { Photo(result: $0) }) //from:
                completion(.success(self.photos))
                NotificationCenter.default.post(name: ImagesListService.didChangeNotification,
                                                object: self,
                                                userInfo: ["Photos": self.photos])
                self.pageNumber += 1
            case .failure(let error):
                print("[objectTask]: ImagesListService - \(error.localizedDescription)")
                completion(.failure(error))
            }
            self.task = nil
        }
        self.task = task
        task.resume()
    }
}


