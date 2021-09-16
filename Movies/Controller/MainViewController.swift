//
//  ViewController.swift
//  Movies
//
//  Created by msc on 17.05.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    var movies = [Movie]()
    let apiClient: APIServiceProtocol = APIService()

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
        customNavigationBar()
        setupLayout()
        presentData()
    }

    func customNavigationBar() {
        navigationItem.title = "Movies"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .black
    }

    func presentData() {
        apiClient.getData { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies.results
                    self.tableView.reloadData()
                case .failure( _):
                    self.movies = []
                    self.tableView.reloadData()
                }
            }
        }
    }

    func setupLayout() {
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
        let movie = movies[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.movie = movie
        // navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(detailVC, animated: true)

    }

}
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainMovieCell.identifier, for: indexPath) as? MainMovieCell else {return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.setupCell(model: movie)
        return cell
    }

}
