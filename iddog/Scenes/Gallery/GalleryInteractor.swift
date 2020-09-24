//
//  GalleryInteractor.swift
//  iddog
//
//  Created by Arthur Kazuo on 22/09/20.
//

import Foundation

protocol GalleryBusinessLogic {
    func getGallery(breed: String)
    func expandDogImage(url: String?)
}

class GalleryInteractor: APIResponse, GalleryBusinessLogic {

    private let worker: GalleryWorkerProtocol
    private let presenter: GalleryPresentationLogic

    //MARK: Initializers
    init(worker: GalleryWorkerProtocol, presenter: GalleryPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }

    //MARK: APIResponse protocol conforms
    func success(_ data: Data) {
        presenter.stopLoading()
        do {
            let gallery = try JSONDecoder().decode(DogGalleryModel.self, from: data)
            presenter.presentGallery(images: gallery)
        } catch {
            presenter.showError()
        }

    }

    func failure(_ error: Error?) {
        presenter.stopLoading()
        presenter.showError()
    }

    //MARK: GalleryBusinessLogic protocol conforms
    func getGallery(breed: String) {
        presenter.showLoading()
        worker.getGallery(breed: breed)
    }

    func expandDogImage(url: String?) {
        presenter.presentExpandedImage(url: url)
    }

}
