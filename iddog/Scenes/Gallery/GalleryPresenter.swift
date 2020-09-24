//
//  GalleryPresenter.swift
//  iddog
//
//  Created by Arthur Kazuo on 22/09/20.
//

import Foundation

protocol GalleryPresentationLogic {
    func presentGallery(images: DogGalleryModel)
    func presentExpandedImage(url: String?)
    func showLoading()
    func stopLoading()
    func showError()
}

class GalleryPresenter: GalleryPresentationLogic {
    private weak var delegate: GalleryDisplayDelegate?

    // MARK: Initializer
    init(delegate: GalleryDisplayDelegate) {
        self.delegate = delegate
    }

    // MARK: GalleryPresentationLogic protocol conforms
    func presentGallery(images: DogGalleryModel) {
        delegate?.presentGallery(images: images)
    }

    func presentExpandedImage(url: String?) {
        delegate?.presentExpandedImage(url: url)
    }

    func showLoading() {
        delegate?.showLoading()
    }

    func stopLoading() {
        delegate?.stopLoading()
    }

    func showError() {
        delegate?.showError()
    }

}
