//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Мария Шагина on 02.03.2024.
//

import Foundation

protocol OAuth2TokenStorageProtocol {
    var token: String? {get}
}

final class OAuth2TokenStorage: OAuth2TokenStorageProtocol {
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case token
    }
    internal var token: String?  {
        get {
            userDefaults.string(forKey: Keys.token.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.token.rawValue)
        }
    }
}
