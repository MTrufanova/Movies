//
//  MoviesModel.swift
//  Movies
//
//  Created by msc on 17.05.2021.
//

import Foundation

struct MoviesResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let poster: String?
    let overview: String
    let releaseDate: String
    let id: Int
    let originalTitle: String
    let title: String
    let voteAverage: Double
    var imagePosterUrl: URL? {
        return URL(string: "\("https://image.tmdb.org/t/p/w500/")\(poster ?? " ")")
      }

    var yearOfRelease: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        guard let formattedDate = formatter.date(from: releaseDate) else {return ""}
        formatter.dateFormat = "YYYY"
       return formatter.string(from: formattedDate)
    }

    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case voteAverage = "vote_average"
        case overview, id, title
    }
}

struct  DetailMovie: Decodable {
    let adult: Bool
        let backdropPath: String?
        let budget: Int
        let genres: [Genre]
        let homepage: String
        let id: Int
        let imdbID, originalLanguage, originalTitle, overview: String
        let popularity: Double
        let productionCompanies: [ProductionCompany]
        let productionCountries: [ProductionCountry]
        let releaseDate: String
        let revenue, runtime: Int
        let spokenLanguages: [SpokenLanguage]
        let status, tagline, title: String
        let voteAverage: Double
        let voteCount: Int

    var imagePosterUrl: URL? {
        return URL(string: "\("https://image.tmdb.org/t/p/w500/")\(backdropPath ?? " ")")
      }

    enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case budget, genres, homepage, id
            case imdbID = "imdb_id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case productionCompanies = "production_companies"
            case productionCountries = "production_countries"
            case releaseDate = "release_date"
            case revenue, runtime
            case spokenLanguages = "spoken_languages"
            case status, tagline, title
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
            case id
            case logoPath = "logo_path"
            case name
            case originCountry = "origin_country"
        }
}

struct ProductionCountry: Codable {
    let shortName, name: String

    enum CodingKeys: String, CodingKey {
        case shortName = "iso_3166_1"
        case name
    }
}
    struct SpokenLanguage: Codable {
        let shortName, name: String

        enum CodingKeys: String, CodingKey {
            case shortName = "iso_639_1"
            case name
        }
    }
