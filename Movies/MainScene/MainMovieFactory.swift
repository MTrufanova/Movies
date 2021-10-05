//
//  MainMovieFactory.swift
//  Movies
//
//  Created by msc on 25.09.2021.
//

import UIKit

protocol MainMovieFactoryProtocol {
     func configuredMainMovieScene() -> UIViewController
}

final class MainMovieFactory: MainMovieFactoryProtocol {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

     func configuredMainMovieScene() -> UIViewController {
        let mainMovieView = MainViewController()
        let networkManager = NetworkService()
        let router = MainMovieRouter(navigationController: navigationController)
        let presenter = MainMoviePresenter(networkManager: networkManager, router: router, mainMovieView: mainMovieView)
        mainMovieView.presenter = presenter
        return mainMovieView
    }

}
