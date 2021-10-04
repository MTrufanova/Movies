//
//  ViewController.swift
//  Movies
//
//  Created by msc on 17.05.2021.
//

import UIKit
import SnapKit

protocol MainMovieViewProtocol: AnyObject {
    func succesLoad()
    func failureLoad(error: Error)
}

class MainViewController: UIViewController {

    var presenter: MainMoviePresenterProtocol?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .black
        tableView.register(MainMovieCell.self, forCellReuseIdentifier: MainMovieCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadMovies()
        customNavigationBar()
        setupLayout()
    }

   private func customNavigationBar() {
        navigationItem.title = "Movies"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
    }

   private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = presenter?.movies[indexPath.row]
        let detailVC = DetailMovieFactory.configuredDetailMovieScene(movie: movie)
       // detailVC.movie = movie
        // navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(detailVC, animated: true)

    }

}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.movies.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainMovieCell.identifier, for: indexPath) as? MainMovieCell else {return UITableViewCell() }
        guard let movie = presenter?.movies[indexPath.row] else { return UITableViewCell() }
        cell.setupCell(model: movie)
        return cell
    }

}

extension MainViewController: MainMovieViewProtocol {
    func succesLoad() {
        tableView.reloadData()
    }

    func failureLoad(error: Error) {
        
    }

}
