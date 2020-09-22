//
//  LoginFailMock.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 21/09/20.
//

@testable import iddog
import Foundation

final class LoginFailMock: LoginWorkerProtocol {
    var delegate: APIResponse?
    let data = Data()

    func login(email: String) {
        delegate?.failure(nil)
    }
}
