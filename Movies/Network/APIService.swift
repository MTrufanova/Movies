//
//  APIServise.swift
//  Movies
//
//  Created by msc on 17.05.2021.
//

import Foundation

enum APIError: Error {
    case noData
}

protocol APIServiceProtocol {
    func getData(onResult: @escaping (Result<MoviesResponse, Error>) -> Void)
}

class APIService: APIServiceProtocol {
    
    func getData(onResult: @escaping (Result<MoviesResponse, Error>) -> Void) {
        let session = URLSession.shared
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=88dfd0596c329813d138ae328b55d439") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                onResult(.failure(APIError.noData))
                return
            }
            do {
                let movieResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                onResult(.success(movieResponse))
            } catch let error{
                print(error)
                onResult(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    
}
