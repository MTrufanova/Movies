//
//  MainMoviePresenter.swift
//  Movies
//
//  Created by msc on 25.09.2021.
//

import Foundation

protocol MainMoviePresenterProtocol: AnyObject {
    var movies: [Movie] { get }
    func loadMovies()
}

final class MainMoviePresenter: MainMoviePresenterProtocol {
    private(set) var movies = [Movie]()
    let networkManager: NetworkServiceProtocol
    weak var mainMovieView: MainMovieViewProtocol?

    init(networkManager: NetworkServiceProtocol, mainMovieView: MainMovieViewProtocol) {
        self.networkManager = networkManager
        self.mainMovieView = mainMovieView
    }

    func loadMovies() {
        networkManager.getData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let netMovies):
                self.movies = netMovies.results
                self.mainMovieView?.succesLoad()
            case .failure(let error):
                self.mainMovieView?.failureLoad(error: error)
            }
        }
    }

}
