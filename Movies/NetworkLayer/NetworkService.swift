//
//  NetworkService.swift
//  Movies
//
//  Created by msc on 17.05.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getData(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {

    private let queue = DispatchQueue.global(qos: .utility)

    let session = URLSession.shared

    func getData(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void) {

        queue.async { [weak self] in
            guard let self = self else { return }
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=88dfd0596c329813d138ae328b55d439") else {
                completion(.failure(.failedToCreateUrl))
                return }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethods.GET.rawValue

            let dataTask = self.session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(.failure(.networkingError(error)))
                }

                guard let response = response as? HTTPURLResponse,
                      let data = data
                      else {
                    completion(.failure(.noResponseOrData))
                    return
                }

                guard response.statusCode >= 200, response.statusCode < 300 else {
                    completion(.failure(.invalidStatusCode(response.statusCode)))
                    return
                }

                do {
                    let jsonData = try JSONDecoder().decode(MoviesResponse.self, from: data)

                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                } catch let error {
                    completion(.failure(.deserializationError(error)))
                }
            }
            dataTask.resume()
        }
    }
}
