//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Мария Шагина on 02.03.2024.
//

import UIKit

final class OAuth2Service {
    
    static let shared = OAuth2Service()
    
    private let urlSession = URLSession.shared
    
    private var authToken: String? {
        get {
            return OAuth2TokenStorage().token
        }
        set {
            OAuth2TokenStorage().token = newValue
        }
    }
    
    func makeOAuthTokenRequest(code: String) -> URLRequest {
        
        guard let baseURL = URL(string: "https://unsplash.com") else {
            preconditionFailure("Unable to construct Base URL")
        }
        let tokenURLPath = "/oauth/token" + "?client_id=\(accessKey)" + "&&client_secret=\(secretKey)" + "&&redirect_uri=\(redirectURI)" + "&&code=\(code)" + "&&grant_type=authorization_code"
        
        guard let url = URL(string: tokenURLPath,
                            relativeTo: baseURL
        ) else {
            preconditionFailure("Unable to construct Token URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
    func fetchOAuthToken(with code: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let completionMainStream: (Result<String, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let request = makeOAuthTokenRequest(code: code)
        let task = fetchOAuthTokenResponseBody(for: request) { [weak self] result in
            guard let self else { preconditionFailure("Unable to construct Token Auth Request") }
            switch result {
            case .success(let body):
                self.authToken = body.accessToken
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
}


