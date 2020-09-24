//
//  HomeResult.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 24/09/20.
//

import UIKit
import class KIF.KIFTestCase
import XCTest
@testable import iddog

final class HomeResult: TestsResult {
    private let sut: HomeViewController
    // MARK: Initializer

    init(spec: KIFTestCase?, sut: HomeViewController?) throws {
        self.sut = try sut.require()

        super.init(spec: spec)
    }

    func hasElements() {
        presence(identifier: "HomeView")
        presence(identifier: "HomeTableView")
    }

    func hasGalleryView() {
        presence(identifier: "GalleryView")
    }
}
