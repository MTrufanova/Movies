//
//  DetailMovieFactory.swift
//  Movies
//
//  Created by msc on 04.10.2021.
//

import Foundation
import UIKit

protocol DetailMovieFactoryProtocol {

    static func configuredDetailMovieScene(movie: Movie?) -> UIViewController
}

final class DetailMovieFactory: DetailMovieFactoryProtocol {
    static func configuredDetailMovieScene(movie: Movie?) -> UIViewController {
        let networkManager = NetworkService()
        let detailView = DetailViewController()
        let presenter = DetailMoviePresenter(movie: movie, networkManager: networkManager, detailView: detailView)
        detailView.presenter = presenter
        return detailView
    }

}
