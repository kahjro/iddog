//
//  GalleryRobot.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 24/09/20.
//

import UIKit
import class KIF.KIFTestCase
import KeychainSwift
@testable import iddog

final class GalleryRobot {
    private weak var spec: KIFTestCase?

    // MARK: Variables

    private(set) var sut: GalleryViewController!

    // MARK: Initializer

    init(spec: KIFTestCase) {
        self.spec = spec
    }

    deinit {
        spec?.clearRootViewController()
    }

    // MARK: Functions

    func loadScreenWithSuccess() -> Self {
        return loadScreenWithProvider(GallerySuccessMock())
    }

    func loadWithError() -> Self {
        return loadScreenWithProvider(GalleryFailMock())
    }

    func tapCell() -> Self {
        spec?.tester().tapItem(at: IndexPath(row: 1, section: 0), inCollectionViewWithAccessibilityIdentifier: "GalleryCollectionView")
        return self
    }

    func result() throws -> GalleryResult {
        return try GalleryResult(spec: spec, sut: sut)
    }

    // MARK: Private functions

    private func loadScreenWithProvider(_ provider: GalleryWorkerProtocol) -> Self {
        sut = GalleryViewController(breed: "husky")
        sut.worker = provider

        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: sut)

        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        spec?.tester().waitForAnimationsToFinish()

        return self
    }
}
