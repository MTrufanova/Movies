//
//  MainMovieRouter.swift
//  Movies
//
//  Created by msc on 04.10.2021.
//

import Foundation
import UIKit

protocol MainMovieRouterProtocol {

    func pushDetailInfo(for movie: Movie)
}

final class MainMovieRouter: MainMovieRouterProtocol {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    func pushDetailInfo(for movie: Movie) {
        if (navigationController?.topViewController as? DetailViewProtocol) != nil {
            return
        } else {
            let detailMovieVC = DetailMovieFactory.configuredDetailMovieScene(movie: movie)
            navigationController?.pushViewController(detailMovieVC, animated: true)

        }
    }

}
