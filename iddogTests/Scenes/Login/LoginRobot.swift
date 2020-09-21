//
//  LoginRobot.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 19/09/20.
//

import UIKit
import class KIF.KIFTestCase
import KeychainSwift
@testable import iddog

final class LoginRobot {
    private weak var spec: KIFTestCase?

    // MARK: Variables

    private(set) var sut: LoginViewController!

    // MARK: Initializer

    init(spec: KIFTestCase) {
        self.spec = spec
    }

    deinit {
        spec?.clearRootViewController()
    }

    // MARK: Functions

    func loadScreenWithoutPersistence() -> Self {
        let keychain = KeychainSwift()
        keychain.clear()
        return loadScreenWithProvider(LoginSuccessMock())
    }

    func typeEmail(email: String) -> Self {
        spec?.tester().tapView(withAccessibilityIdentifier: "LoginTxtField")
        spec?.tester().validateEnteredText(true)?.enterText(intoCurrentFirstResponder: email)
        return self
    }

    func tapLoginButton() -> Self {
        spec?.tester().tapView(withAccessibilityIdentifier: "LoginBtn")
        return self
    }

    func result() throws -> LoginResult {
        return try LoginResult(spec: spec, sut: sut)
    }

    // MARK: Private functions

    private func loadScreenWithProvider(_ provider: LoginWorkerProtocol) -> Self {
        sut = LoginViewController()
        sut.worker = provider

        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: sut)

        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()

        return self
    }
}
