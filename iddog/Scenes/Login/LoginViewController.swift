//
//  LoginViewController.swift
//  iddog
//
//  Created by Arthur Kazuo on 19/09/20.
//

import UIKit

class LoginViewController: UIViewController {
    private var loginView: UIView = {
        var view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(loginView, constraints: [
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
