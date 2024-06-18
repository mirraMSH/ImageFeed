//
//  AlertPresenter.swift
//  ImageFeed
//
//  Created by Мария Шагина on 16.06.2024.
//

import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: ((UIAlertAction) -> ())?
}

final class AlertPresenter {
    func showAlert(in vc: UIViewController, with model: AlertModel, erorr: Error?) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: model.buttonText,
            style: .default,
            handler: model.completion)
        
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
