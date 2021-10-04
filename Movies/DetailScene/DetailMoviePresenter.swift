//
//  DetailMoviePresenter.swift
//  Movies
//
//  Created by msc on 29.09.2021.
//

import Foundation

protocol DetailMoviePreseterProtocol: AnyObject {
    func loadMovie()
    
}

final class DetailMoviePresenter: DetailMoviePreseterProtocol {
    private var movie: Movie?
    let networkManager: NetworkServiceProtocol
    var detailView: DetailViewProtocol?

    init(movie: Movie?, networkManager: NetworkServiceProtocol, detailView: DetailViewProtocol) {
        self.movie = movie
        self.networkManager = networkManager
        self.detailView = detailView
    }
    
    func loadMovie() {
        self.detailView?.showMovie(movie: movie)
    }
}
