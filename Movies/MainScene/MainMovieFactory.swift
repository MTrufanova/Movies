//
//  MainMovieFactory.swift
//  Movies
//
//  Created by msc on 25.09.2021.
//

import UIKit

protocol MainMovieFactoryProtocol {
    static func configuredMainMovieScene() -> UIViewController
}

final class MainMovieFactory: MainMovieFactoryProtocol {
    static func configuredMainMovieScene() -> UIViewController {
        let mainMovieView = MainViewController()
        let networkManager = NetworkService()
        let presenter = MainMoviePresenter(networkManager: networkManager, mainMovieView: mainMovieView)
        mainMovieView.presenter = presenter
        return mainMovieView
    }

}
