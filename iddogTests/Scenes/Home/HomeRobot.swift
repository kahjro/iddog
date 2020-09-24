//
//  HomeRobot.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 24/09/20.
//

import UIKit
import class KIF.KIFTestCase
import KeychainSwift
@testable import iddog

final class HomeRobot {
    private weak var spec: KIFTestCase?

    // MARK: Variables

    private(set) var sut: HomeViewController!

    // MARK: Initializer

    init(spec: KIFTestCase) {
        self.spec = spec
    }

    deinit {
        spec?.clearRootViewController()
    }

    // MARK: Functions

    func tapCell(row: Int) -> Self {
        spec?.tester().tapRow(at: IndexPath(row: row, section: 0), inTableViewWithAccessibilityIdentifier: "HomeTableView")
        return self
    }

    func result() throws -> HomeResult {
        return try HomeResult(spec: spec, sut: sut)
    }

    // MARK: Private functions

    func loadScreen() -> Self {
        sut = HomeViewController()

        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: sut)

        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()

        return self
    }
}
