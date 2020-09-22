//
//  HomeViewController.swift
//  iddog
//
//  Created by Arthur Kazuo on 19/09/20.
//

import UIKit
import KeychainSwift

class HomeViewController: UIViewController {
    private lazy var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .mainPurple
        view.accessibilityIdentifier = "HomeView"
        return view
    }()

    private lazy var homeTableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.accessibilityIdentifier = "HomeTableView"
        return tableView
    }()

    private lazy var navigationBar: UINavigationBar = {
        var navBar = UINavigationBar()
        navBar.isTranslucent = false
        navBar.barTintColor = .mainPurple
        let navigationItem = UINavigationItem()
            navigationItem.title = "Menu"
        let rightButton = UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(logout))
            rightButton.tintColor = .white

        navigationItem.rightBarButtonItem = rightButton
        navBar.items = [navigationItem]

        return navBar
    }()

    private let dogRaces = ["Husky","Hound","Pug","Labrador"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @objc private func logout() {
        let keychain = KeychainSwift()
        keychain.clear()
        navigationController?.setViewControllers([LoginViewController()], animated: true) 
    }

    private func setupLayout() {
        self.title = "Home"
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

        backgroundView.addSubview(homeTableView, constraints: [
            homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .offPurple
        cell.textLabel?.text = dogRaces[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
