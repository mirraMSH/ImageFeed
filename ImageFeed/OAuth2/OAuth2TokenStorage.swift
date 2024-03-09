//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Мария Шагина on 02.03.2024.
//

import UIKit


final class OAuth2TokenStorage {
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "BearerToken")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "BearerToken")
        }
    }
}
