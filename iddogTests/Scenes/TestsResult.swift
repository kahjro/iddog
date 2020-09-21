//
//  TestsResult.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 19/09/20.
//

import class KIF.KIFTestCase
import XCTest

protocol TestsResultProtocol where Self: TestsResult {
    var spec: KIFTestCase? { get }
}

class TestsResult: TestsResultProtocol {
    private(set) weak var spec: KIFTestCase?

    // MARK: Initializer

    init(spec: KIFTestCase?) {
        assert(spec != nil)

        self.spec = spec
    }

    func absence(identifier: String) {
        spec?.tester().waitForAbsenceOfView(withAccessibilityIdentifier: identifier)
    }

    func presence(identifier: String) {
        spec?.tester().waitForView(withAccessibilityIdentifier: identifier)
    }
}
