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
    func pushDetailVC(for movie: Movie)
}

final class MainMoviePresenter: MainMoviePresenterProtocol {
    private(set) var movies = [Movie]()
    private let networkManager: NetworkServiceProtocol
    private let router: MainMovieRouterProtocol
    weak var mainMovieView: MainMovieViewProtocol?

    init(networkManager: NetworkServiceProtocol, router: MainMovieRouterProtocol, mainMovieView: MainMovieViewProtocol) {
        self.networkManager = networkManager
        self.router = router
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

    func pushDetailVC(for movie: Movie) {
        router.pushDetailInfo(for: movie)
    }

}
