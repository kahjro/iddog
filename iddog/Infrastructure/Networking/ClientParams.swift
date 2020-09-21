//
//  ClientParams.swift
//  iddog
//
//  Created by Arthur Kazuo on 19/09/20.
//  Copyright © 2020 Arthur Kazuo. All rights reserved.
//

import Foundation

class ClientParams: NSObject {
    var method: String?
    var query: [AnyHashable : Any]?
    var path: [AnyHashable : Any]?
    var header: [AnyHashable : Any]?
    var body: [AnyHashable : Any]?
    init(dictionary: [AnyHashable : Any]?) {

    }
}

enum HTTPMethodsEnum: String {
    case GET
    case POST
    case DELETE
    case UPDATE
}
