//
//  HomeInteractor.swift
//  iddog
//
//  Created by Arthur Kazuo on 22/09/20.
//

import KeychainSwift

protocol HomeBusinessLogic {
    func presentDogsController(breed: String)
    func logoutSession()
}

class HomeInteractor: HomeBusinessLogic {

    private let presenter: HomePresentationLogic

    //MARK: Initializers
    init(presenter: HomePresentationLogic) {
        self.presenter = presenter
    }

    //MARK: HomeBusinessLogic protocol conforms
    func logoutSession() {
        let keychain = KeychainSwift()
        keychain.clear()
        presenter.logoutSession()
    }

    func presentDogsController(breed: String) {
        let dogBreed = breed.lowercased()
        presenter.presentDogsController(breed: dogBreed)
    }
}

