//
//  GallerySuccessMock.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 24/09/20.
//

@testable import iddog
import Foundation

final class GallerySuccessMock: GalleryWorkerProtocol {
    var delegate: APIResponse?
    let data = Data()

    func getGallery(breed: String) {
        delegate?.success(data.dataJson(file: "DogGalleryMock"))
    }
}
