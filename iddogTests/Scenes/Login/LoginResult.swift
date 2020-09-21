//
//  LoginResult.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 19/09/20.
//

import UIKit
import class KIF.KIFTestCase
import XCTest
@testable import iddog

final class LoginResult: TestsResult {
    private let sut: LoginViewController
    // MARK: Initializer

    init(spec: KIFTestCase?, sut: LoginViewController?) throws {
        self.sut = try sut.require()

        super.init(spec: spec)
    }

    func hasElements() {
        presence(identifier: "LoginView")
        presence(identifier: "LoginTxtField")
        presence(identifier: "LoginBtn")
    }

    @discardableResult
    func has(email: String) throws -> Self {
        let emailFieldView: UITextView = try spec.require().tester().waitForElementWith(accessibilityIdentifier: "LoginTxtField")
            spec?.tester().waitForAnimationsToFinish()

        XCTAssertEqual(emailFieldView.text, email)

        return self
    }

    @discardableResult
    func hasWrongEmail() throws -> Self {
        let emailFieldView: UITextView = try spec.require().tester().waitForElementWith(accessibilityIdentifier: "LoginTxtField")
            spec?.tester().waitForAnimationsToFinish()

        XCTAssertFalse(emailFieldView.text.isValidEmail())

        return self
    }

    @discardableResult
    func hasValidEmail() throws -> Self {
        let emailFieldView: UITextView = try spec.require().tester().waitForElementWith(accessibilityIdentifier: "LoginTxtField")
            spec?.tester().waitForAnimationsToFinish()

        XCTAssertTrue(emailFieldView.text.isValidEmail())

        return self
    }

    @discardableResult
    func hasErrorAlert() -> Self {
        presence(identifier: "AlertView")

        return self
    }

    func hasHomeView() {
        presence(identifier: "HomeView")
    }
}
