//
//  LoginInteractor.swift
//  iddog
//
//  Created by Arthur Kazuo on 19/09/20.
//

import Alamofire
import KeychainSwift

protocol LoginBusinessLogic {
    func login(email: String)
}

class LoginInteractor: APIResponse, LoginBusinessLogic {

    private let worker: LoginWorkerProtocol
    private let presenter: LoginPresentationLogic

    //MARK: Initializers
    init(worker: LoginWorkerProtocol, presenter: LoginPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }

    //MARK: APIResponse protocol conforms
    func success(_ data: Data) {
        presenter.stopLoading()
        do {
            let login = try JSONDecoder().decode(LoginModel.self, from: data)
            let keychain = KeychainSwift()
            keychain.set(login.user.token, forKey: "token")
            presenter.presentHome()
        } catch {
            presenter.showError()
        }

    }

    func failure(_ error: Error?) {
        presenter.stopLoading()
        presenter.showError()
    }

    //MARK: LoginBusinessLogic protocol conforms
    func login(email: String) {
        presenter.showLoading()
        worker.login(email: email)
    }
}
