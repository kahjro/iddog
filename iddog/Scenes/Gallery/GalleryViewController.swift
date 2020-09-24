//
//  GalleryViewController.swift
//  iddog
//
//  Created by Arthur Kazuo on 22/09/20.
//

import UIKit

protocol GalleryDisplayDelegate: class {
    func presentGallery(images: DogGalleryModel)
    func presentExpandedImage(url: String?)
    func showLoading()
    func stopLoading()
    func showError()
}

class GalleryViewController: UIViewController {
    private lazy var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .mainPurple
        view.accessibilityIdentifier = "GalleryView"
        return view
    }()

    private lazy var navigationBar: UINavigationBar = {
        var navBar = UINavigationBar()
        navBar.isTranslucent = false
        navBar.barTintColor = .mainPurple
        let navigationItem = UINavigationItem()
            navigationItem.title = breed
        let rightButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(close))
            rightButton.tintColor = .white

        navigationItem.leftBarButtonItem = rightButton
        navBar.items = [navigationItem]

        return navBar
    }()

    private lazy var galleryCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.bounds.width / 4 , height: view.bounds.width / 4)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.accessibilityIdentifier = "GalleryCollectionView"
        return collectionView
    }()

    private var viewModel: DogGalleryModel?
    private var imagesCount: Int = 1
    private var breed: String

    // MARK: Lazy variables
    lazy var worker: GalleryWorkerProtocol = GalleryWorker()
    lazy var interactor: GalleryBusinessLogic & APIResponse = {
        return GalleryInteractor(worker: worker, presenter: presenter)
    }()
    lazy var presenter: GalleryPresentationLogic = GalleryPresenter(delegate: self)

     init(breed: String) {
        self.breed = breed
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        galleryCollectionView.register(DogImageCell.self, forCellWithReuseIdentifier: "default")
        setupLayout()
        setupArch()
        interactor.getGallery(breed: breed)
    }

    @objc private func close() {
        navigationController?.popViewController(animated: true)
    }

    private func setupLayout() {
        view.addSubview(backgroundView, constraints: [
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        backgroundView.addSubview(navigationBar, constraints: [
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
        ])

        backgroundView.addSubview(galleryCollectionView, constraints: [
            galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            galleryCollectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    //MARK: Setup archtecture
    private func setupArch() {
        worker.delegate = interactor
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as! DogImageCell
        cell.config(url: viewModel?.imageList[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.expandDogImage(url: viewModel?.imageList[indexPath.row])
    }
}

extension GalleryViewController: GalleryDisplayDelegate {
    func presentGallery(images: DogGalleryModel) {
        viewModel = images
        imagesCount = images.imageList.count
        galleryCollectionView.reloadData()
    }

    func presentExpandedImage(url: String?) {
        navigationController?.pushViewController(DogImageViewController(url: url), animated: true)
    }

    func showLoading() {
        showSpinner(onView: view)
    }

    func stopLoading() {
        removeSpinner()
    }

    func showError() {
        let alert = UIAlertController(title: "erro", message: "ocorreu um erro ao buscar as imagens", preferredStyle: UIAlertController.Style.alert)
        alert.view.accessibilityIdentifier = "AlertView"
        alert.addAction(UIAlertAction(title: "fechar", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }


}
