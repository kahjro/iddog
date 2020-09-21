//
//  LoginWorker.swift
//  iddog
//
//  Created by Arthur Kazuo on 19/09/20.
//

import Foundation
import Alamofire

protocol LoginWorkerProtocol: class {
    var delegate: APIResponse? { get set }

    func login(email: String)
}

class LoginWorker: NSObject, LoginWorkerProtocol {
    var delegate: APIResponse?
    var params: [String: Any] = ["Content-Type":"application/json"]
    var baseURL: String = ""

    func login(email: String) {
        baseURL = "https://iddog-nrizncxqba-uc.a.run.app/signup"
        params.updateValue(email, forKey: "email")
        Alamofire.request(baseURL, method: .post, parameters: params).validate(statusCode: 200..<299).responseData { response in

            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                self.delegate?.success(data)
            case .failure(let error):
                self.delegate?.failure(error)
            }
        }
    }
}
