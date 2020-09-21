//
//  KIF+Extensions.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 19/09/20.
//

import KIF
import UIKit
import Foundation

extension XCTestCase {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
    return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
    return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }

    func clearRootViewController() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(
            rootViewController: UIViewController()
        )
    }
}

extension Data {
    func dataJson(file: String, type: String = "json") -> Self {
        guard let pathFromBundle = Bundle.main.path(forResource: file, ofType: type) else { return Data() }

        let url = URL(fileURLWithPath: pathFromBundle)

        guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else { return Data() }

        return data
    }
}

extension KIFTestActor {
    func tester(file : String = #file, _ line : Int = #line) -> KIFUITestActor {
    return KIFUITestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(file : String = #file, _ line : Int = #line) -> KIFSystemTestActor {
    return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }

    func waitForElementWith<T>(accessibilityIdentifier identifier: String, in view: UIView? = nil) -> T {

        if let rootView = view {
            var element: UIAccessibilityElement?
            var view: UIView?
            tester().wait(for: &element, view: &view, withIdentifier: identifier, fromRootView: rootView, tappable: false)

            guard let viewFound = view as? T else {
                fatalError("\(identifier) are not \(String(describing: T.self)).")
            }

            return viewFound

        } else {
            guard let element = self.waitForViewWith(accessibilityIdentifier: identifier) as? T
                    else {
                fatalError("\(identifier) are not \(String(describing: T.self)).")
            }
            return element
        }
    }

    //
    // MARK: Wait for View
    //
    func waitForViewWith(accessibilityIdentifier identifier: String) -> UIView? {
        return self.waitForTappableViewWith(accessibilityIdentifier: identifier, mustBeTappable: false)
    }

    func waitForTappableViewWith(accessibilityIdentifier identifier: String) -> UIView? {
        return self.waitForTappableViewWith(accessibilityIdentifier: identifier, mustBeTappable: true)
    }

    func waitForTappableViewWith(accessibilityIdentifier identifier: String, mustBeTappable: Bool) -> UIView? {
        var view: UIView?
        tester().wait(for: nil, view: &view, withIdentifier: identifier, tappable: mustBeTappable)
        return view
    }
}

private class Mapper<N> where N: Decodable {
    func map(file: String, type: String) -> N? {
        guard let pathFromBundle = Bundle.main.path(forResource: file, ofType: type) else {
            return nil
        }

        let url = URL(fileURLWithPath: pathFromBundle)

        guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else {
            return nil
        }

        return try? JSONDecoder().decode(N.self, from: data)
    }
}

extension Decodable {
    init(path: String, type: String = "json") {
        guard let mapped = Mapper<Self>().map(file: path, type: type) else {
            fatalError()
        }

        self = mapped
    }
}
