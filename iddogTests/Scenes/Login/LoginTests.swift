//
//  iddogTests.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 14/09/20.
//

import class KIF.KIFTestCase
import KeychainSwift
@testable import iddog


final class LoginTests: KIFTestCase {
    private var robot: LoginRobot!

    // MARK: Override functions

    override func setUp() {
        super.setUp()
        let keychain = KeychainSwift()
        keychain.clear()
        robot = LoginRobot(spec: self)
    }

    override func tearDown() {
        super.tearDown()
        robot = nil
    }

    func testInit() throws {
        try robot.require()
            .loadScreenWithoutPersistence()
            .result()
            .hasElements()
    }

    func testWrongEmail() throws {
        try robot.require()
            .loadScreenWithoutPersistence()
            .typeEmail(email: "Lorem Ipsum")
            .result()
            .has(email: "Lorem Ipsum")
            .hasWrongEmail()
    }

    func testValidEmail() throws {
        try robot.require()
            .loadScreenWithoutPersistence()
            .typeEmail(email: "Teste@teste.com")
            .result()
            .has(email: "Teste@teste.com")
            .hasValidEmail()
    }

    func testWrongEmailAlert() throws {
        try robot.require()
            .loadScreenWithoutPersistence()
            .typeEmail(email: "Lorem Ipsum")
            .tapLoginButton()
            .result()
            .hasWrongEmail()
            .hasErrorAlert()
    }

    func testLogon() throws {
        try robot.require()
            .loadScreenWithoutPersistence()
            .typeEmail(email: "Teste@teste.com")
            .tapLoginButton()
            .result()
            .hasHomeView()
    }
}
