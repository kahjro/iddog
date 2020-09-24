//
//  HomeTests.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 24/09/20.
//

import class KIF.KIFTestCase
import KeychainSwift
@testable import iddog


final class HomeTests: KIFTestCase {
    private var robot: HomeRobot!
    private let keychain = KeychainSwift()

    // MARK: Override functions

    override func setUp() {
        super.setUp()
        keychain.set("1234567890", forKey: "token")
        robot = HomeRobot(spec: self)
    }

    override func tearDown() {
        super.tearDown()
        keychain.clear()
        robot = nil
    }

    func testInit() throws {
        try robot.require()
            .loadScreen()
            .result()
            .hasElements()
    }

    func testPresentGallery() throws {
        try robot.require()
            .loadScreen()
            .tapCell(row: 1)
            .result()
            .hasGalleryView()
    }

    func testLogout() throws {
        try robot.require()
            .loadScreen()
            .tapLogout()
            .result()
            .hasLoginView()
    }
}
