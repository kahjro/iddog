//
//  LoginViewController.swift
//  iddog
//
//  Created by Arthur Kazuo on 19/09/20.
//

import UIKit

protocol LoginDisplayDelegate: class {
    func presentHome()
    func showLoading()
    func stopLoading()
    func showError()
}

class LoginViewController: UIViewController, LoginDisplayDelegate {

    private var loginView: UIView = {
        var view = UIView()
        view.backgroundColor = .mainPurple
        view.accessibilityIdentifier = "LoginView"
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
        textField.accessibilityIdentifier = "LoginTxtField"
        textField.isAccessibilityElement = true
        return textField
    }()

    private lazy var loginButton: UIButton = {
        var button = UIButton()
        button.setTitle("Entrar", for: [])
        button.addTarget(self, action: #selector(performLogin), for: .touchUpInside)
        button.backgroundColor = .mainGreen
        button.layer.cornerRadius = 5
        button.accessibilityIdentifier = "LoginBtn"
        return button
    }()

    private lazy var emailLabel: UILabel = {
        var label = UILabel()
        label.text = "Digite seu email"
        label.accessibilityIdentifier = "EmailLabel"
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupArch()
    }

    // MARK: Lazy variables
    lazy var worker: LoginWorkerProtocol = LoginWorker()
    lazy var interactor: LoginBusinessLogic & APIResponse = {
        return LoginInteractor(worker: worker, presenter: presenter)
    }()
    lazy var presenter: LoginPresentationLogic = LoginPresenter(delegate: self)

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

        loginView.addSubview(loginButton, constraints: [
            loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: loginField.widthAnchor, multiplier: 0.6),
            loginButton.heightAnchor.constraint(equalTo: loginView.heightAnchor, multiplier: 0.045),
            loginButton.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 16)

        ])

        loginView.addSubview(emailLabel, constraints: [
            emailLabel.leadingAnchor.constraint(equalTo: loginField.leadingAnchor),
            emailLabel.bottomAnchor.constraint(equalTo: loginField.topAnchor, constant: -5)
        ])
    }

    @objc private func performLogin() {
        if loginField.text.isValidEmail() {
            interactor.login(email: loginField.text)
        } else {
            let alert = UIAlertController(title: "email inválido", message: "por favor insira um email válido", preferredStyle: UIAlertController.Style.alert)
            alert.view.accessibilityIdentifier = "AlertView"
            alert.addAction(UIAlertAction(title: "fechar", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    //MARK: LoginDisplayDelegate protocol conforms
    func presentHome() {
        navigationController?.pushViewController(HomeViewController(), animated: true)
    }

    func showLoading() {
        showSpinner(onView: loginView)
    }

    func stopLoading() {
        removeSpinner()
    }

    func showError() {
        let alert = UIAlertController(title: "erro", message: "ocorreu um erro ao fazer o login", preferredStyle: UIAlertController.Style.alert)
        alert.view.accessibilityIdentifier = "AlertView"
        alert.addAction(UIAlertAction(title: "fechar", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //MARK: Setup archtecture
    private func setupArch() {
        worker.delegate = interactor
    }
}

extension LoginViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
        textView.layer.borderColor = textView.text.isValidEmail() || textView.text == "" ? UIColor.black.cgColor : UIColor.red.cgColor
    }
}
