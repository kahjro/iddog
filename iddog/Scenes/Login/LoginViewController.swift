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

    private lazy var loginField: UITextView = {
        var textField = UITextView()
        textField.delegate = self
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 12)
        textField.textColor = .black
        textField.textContainer.maximumNumberOfLines = 1
        return textField
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

        loginView.addSubview(loginField, constraints: [
            loginField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginField.widthAnchor.constraint(equalTo: loginView.widthAnchor, multiplier: 0.8),
            loginField.heightAnchor.constraint(equalTo: loginView.heightAnchor, multiplier: 0.05),
            loginField.centerYAnchor.constraint(equalTo: loginView.centerYAnchor)
        ])
    }
}

extension LoginViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        textView.layer.borderColor = isValidEmail(textView.text) ? UIColor.black.cgColor : UIColor.red.cgColor
    }

    func isValidEmail(_ email: String) -> Bool {
        if email == "" { return true }
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}", options: .caseInsensitive)
        return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
        }
}
