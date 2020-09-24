//
//  DogImageViewController.swift
//  iddog
//
//  Created by Arthur Kazuo on 24/09/20.
//

import UIKit

class DogImageViewController: UIViewController {
    private lazy var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .mainPurple
        view.accessibilityIdentifier = "DogImageView"
        return view
    }()

    private lazy var navigationBar: UINavigationBar = {
        var navBar = UINavigationBar()
        navBar.isTranslucent = false
        navBar.barTintColor = .mainPurple
        let navigationItem = UINavigationItem()
            navigationItem.title = ""
        let rightButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(close))
            rightButton.tintColor = .white

        navigationItem.leftBarButtonItem = rightButton
        navBar.items = [navigationItem]

        return navBar
    }()

    private lazy var imageView: UIImageView = {
        var view = UIImageView()
        return view
    }()

    @objc private func close() {
        navigationController?.popViewController(animated: true)
    }

    private var imageUrl: String?

    init(url: String?) {
        imageUrl = url
       super.init(nibName: nil, bundle: nil)
   }

    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupImage()
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

        backgroundView.addSubview(imageView, constraints: [
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupImage() {
        guard let urlStr = imageUrl, let url = URL(string: urlStr) else { return }
        imageView.sd_setImage(with: url, placeholderImage: nil, options: .allowInvalidSSLCertificates, progress: nil, completed: { (image, error, cacheType, url) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            }
        })
    }
}
