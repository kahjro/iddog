//
//  HomePresenter.swift
//  iddog
//
//  Created by Arthur Kazuo on 22/09/20.
//

import Foundation

protocol HomePresentationLogic {
    func presentDogsController(breed: String)
    func logoutSession()
}

class HomePresenter: HomePresentationLogic {
    private weak var delegate: HomeDisplayDelegate?

    // MARK: Initializer
    init(delegate: HomeDisplayDelegate) {
        self.delegate = delegate
    }

    // MARK: HomePresentationLogic protocol conforms
    func presentDogsController(breed: String) {
        delegate?.presentDogsController(breed: breed)
    }

    func logoutSession() {
        delegate?.logoutSession()
    }
}

