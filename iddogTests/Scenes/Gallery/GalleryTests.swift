//
//  GalleryTests.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 24/09/20.
//

import class KIF.KIFTestCase
import KeychainSwift
@testable import iddog


final class GalleryTests: KIFTestCase {
    private var robot: GalleryRobot!
    private let keychain = KeychainSwift()

    // MARK: Override functions

    override func setUp() {
        super.setUp()
        keychain.set("1234567890", forKey: "token")
        robot = GalleryRobot(spec: self)
    }

    override func tearDown() {
        super.tearDown()
        keychain.clear()
        robot = nil
    }

    func testInit() throws {
        try robot.require()
            .loadScreenWithSuccess()
            .result()
            .hasElements()
    }

    func testFailure() throws {
        try robot.require()
            .loadWithError()
            .result()
            .hasErrorAlert()
    }

    func testTapImage() throws {
        try robot.require()
            .loadScreenWithSuccess()
            .tapCell()
            .result()
            .hasImageExpandedView()
    }

    
}
