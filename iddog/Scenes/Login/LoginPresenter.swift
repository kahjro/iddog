//
//  LoginPresenter.swift
//  iddog
//
//  Created by Arthur Kazuo on 19/09/20.
//

import Foundation

protocol LoginPresentationLogic {
    func presentHome()
    func showLoading()
    func stopLoading()
    func showError()
}

class LoginPresenter: LoginPresentationLogic {
    private weak var delegate: LoginDisplayDelegate?

    // MARK: Initializer
    init(delegate: LoginDisplayDelegate) {
        self.delegate = delegate
    }

    // MARK: LoginPresentationLogic protocol conforms
    func presentHome() {
        delegate?.presentHome()
    }

    func showLoading() {
        delegate?.showLoading()
    }

    func stopLoading() {
        delegate?.stopLoading()
    }

    func showError() {
        delegate?.showError()
    }
}
