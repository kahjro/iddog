//
//  XCTestCase+RequireError.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 19/09/20.
//

import protocol Foundation.LocalizedError

extension Optional {
    private struct RequireError<T>: LocalizedError {
        let file: StaticString
        let line: UInt

        var errorDescription: String? {
            return "Required value of type \(T.self) was nil at line \(line) in file \(file)."
        }
    }

    func require(file: StaticString = #file, line: UInt = #line) throws -> Wrapped {
        guard let value = self else {
            throw RequireError<Wrapped>(file: file, line: line)
        }

        return value
    }
}
