//
//  LoginModel.swift
//  iddog
//
//  Created by Arthur Kazuo on 19/09/20.
//

import Foundation

struct LoginModel: Codable, Equatable {

    let user: UserData

    enum CodingKeys: String, CodingKey {
        case user = "user"
    }

}

struct UserData: Codable, Equatable {

    let token: String

    enum CodingKeys: String, CodingKey {
        case token = "token"
    }

}
