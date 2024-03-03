//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Мария Шагина on 02.03.2024.
//

import UIKit

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    init() {
        self.urlSession = URLSession.shared
    }
    
    private let urlSession: URLSession
    private var oauth2TokenStorage = OAuth2TokenStorage()
    
    private var authToken: String? {
        get {
            return oauth2TokenStorage.token
        }
        set {
            oauth2TokenStorage.token = newValue
        }
    }
    
    
    func fetchOAuthToken(with code: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let completionMainStream: (Result<String, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let request = makeOAuthTokenRequest(code: code)
        let task = fetchOAuthTokenResponseBody(for: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let body):
                let authToken = body.accessToken
                self.authToken = authToken
                completionMainStream(.success(body.accessToken))
            case .failure(let error):
                completionMainStream(.failure(error))
            }
        }
        task.resume()
    }
}

extension OAuth2Service {
    func fetchOAuthTokenResponseBody(
        for request: URLRequest, completion: @escaping (Result<OAuthTokenResponseBody, Error>) -> Void
    ) -> URLSessionTask {
        let decoder = JSONDecoder()
        return urlSession.data(for: request) { (result: Result<Data, Error>) in
            let response = result.flatMap { data -> Result<OAuthTokenResponseBody, Error> in
                Result { try decoder.decode(OAuthTokenResponseBody.self, from: data) }
            }
            completion(response)
        }
    }
    
    func makeOAuthTokenRequest(code: String) -> URLRequest {
        guard let baseURL = URL(string: "https://unsplash.com") else {
            preconditionFailure("Unable to construct Base URL")
        }
        guard let url = URL(
            string: "/oauth/token"
            + "?client_id=\(Constants.accessKey)"
            + "&&client_secret=\(Constants.secretKey)"
            + "&&redirect_uri=\(Constants.redirectURI)"
            + "&&code=\(code)"
            + "&&grant_type=authorization_code",
            relativeTo: baseURL
        ) else {
            preconditionFailure("Unable to construct Token URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
}


        
        
        


