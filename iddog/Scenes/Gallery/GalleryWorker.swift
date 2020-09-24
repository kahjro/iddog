//
//  GalleryWorker.swift
//  iddog
//
//  Created by Arthur Kazuo on 22/09/20.
//

import Foundation
import Alamofire
import KeychainSwift

protocol GalleryWorkerProtocol: class {
    var delegate: APIResponse? { get set }

    func getGallery(breed: String)
}

class GalleryWorker: NSObject, GalleryWorkerProtocol {
    var delegate: APIResponse?
    let keychain = KeychainSwift()
    var headers = Alamofire.SessionManager.defaultHTTPHeaders
    var params: [String: Any] = [:]
    var baseURL: String = ""

    func getGallery(breed: String) {
        baseURL = "https://iddog-nrizncxqba-uc.a.run.app/feed"
        headers["Authorization"] = keychain.get("token")
        params.updateValue(breed, forKey: "category")

        Alamofire.request(baseURL, method: .get, parameters: params,encoding: URLEncoding.queryString, headers: headers).validate(statusCode: 200..<299).responseData { response in
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
