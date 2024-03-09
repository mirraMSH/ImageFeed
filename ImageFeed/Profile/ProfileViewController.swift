//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Мария Шагина on 24.02.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let avatarImageView = UIImage(named: "Photo")
        let imageView = UIImageView(image: avatarImageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        let nameLabel = UILabel()
        let loginNameLabel = UILabel()
        let descriptionLabel = UILabel()
        
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = .ypWhite
        nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        
        loginNameLabel.text = "@ekaterina_nov"
        loginNameLabel.textColor = .ypGray
        loginNameLabel.font = UIFont.systemFont(ofSize: 13)
        
        descriptionLabel.text = "Hello World!"
        descriptionLabel.textColor = .ypWhite
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(nameLabel)
        view.addSubview(loginNameLabel)
        view.addSubview(descriptionLabel)
        
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: loginNameLabel.trailingAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: loginNameLabel.leadingAnchor).isActive = true
        loginNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8).isActive = true
        
        
        let logoutButton = UIButton.systemButton(with: UIImage(named: "Exit")!, target: self, action: #selector(self.didTapLogoutButton))
        logoutButton.tintColor = .ypRed
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 24).isActive = true

    }
    
    @objc
    private func didTapLogoutButton() { }
    
}

extension UIColor {
     static var ypRed: UIColor { UIColor(named: "YP Red (iOS)") ?? UIColor.red }
     static var ypBlack: UIColor { UIColor(named: "YP Black") ?? UIColor.black}
     static var ypBackground: UIColor { UIColor(named: "YP Background") ?? UIColor.darkGray }
     static var ypGray: UIColor { UIColor(named: "YP Gray") ?? UIColor.gray }
     static var ypWhite: UIColor { UIColor(named: "YP White") ?? UIColor.white}
}
