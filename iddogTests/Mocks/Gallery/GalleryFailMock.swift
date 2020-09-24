//
//  GalleryFailMock.swift
//  iddogTests
//
//  Created by Arthur Kazuo on 24/09/20.
//

@testable import iddog
import Foundation

final class GalleryFailMock: GalleryWorkerProtocol {
    var delegate: APIResponse?
    let data = Data()

    func getGallery(breed: String) {
        delegate?.failure(nil)
    }
}
