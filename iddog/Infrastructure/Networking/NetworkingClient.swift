//
//  NetworkingClient.swift
//  iddog
//
//  Created by Arthur Kazuo on 19/09/20.
//  Copyright © 2020 Arthur Kazuo. All rights reserved.
//

import Foundation
import Alamofire

protocol APIResponse {
    func success(_ data: Data)
    func failure(_ error: Error?)
}
