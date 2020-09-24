//
//  GalleryResult.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 24/09/20.
//

import UIKit
import class KIF.KIFTestCase
import XCTest
@testable import iddog

final class GalleryResult: TestsResult {
    private let sut: GalleryViewController
    // MARK: Initializer

    init(spec: KIFTestCase?, sut: GalleryViewController?) throws {
        self.sut = try sut.require()

        super.init(spec: spec)
    }

    func hasElements() {
        presence(identifier: "GalleryView")
        presence(identifier: "GalleryCollectionView")
    }

    @discardableResult
    func hasErrorAlert() -> Self {
        presence(identifier: "AlertView")

        return self
    }

    func hasImageExpandedView() {
        presence(identifier: "DogImageView")
    }
}
