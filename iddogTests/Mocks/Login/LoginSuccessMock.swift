//
//  LoginSuccessMock.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 19/09/20.
//

@testable import iddog
import Foundation

final class LoginSuccessMock: LoginWorkerProtocol {
    var delegate: APIResponse?
    let data = Data()

    func login(email: String) {
        delegate?.success(data.dataJson(file: "LoginMock"))
    }
}
