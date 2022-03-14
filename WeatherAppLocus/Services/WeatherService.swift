//
//  WeatherService.swift
//  WeatherAppLocus
//
//  Created by Shobhit Jain on 12/03/22.
//

import Foundation
import UIKit

enum FetchWeatherErrors: Error {
    case invalidCity
    case networkError
    case invalidInput
    case invalidData
    
    func getMessage() -> String {
        switch self {
        case . invalidData:
            return "Invalid data from server. Please try again"
        case .invalidInput:
            return "City data invalid"
        case .networkError:
            return "Network error"
        case .invalidCity:
            return "City data invalid"
        }
    }
}

class WeatherService {
    var urlSession: URLSession
    
    init(session: URLSession) {
        self.urlSession = session
    }
    
    func getLatitudeAndLongitude(of city: String, completion: @escaping (Result<(lat: Double, lon: Double), FetchWeatherErrors>) -> Void) {
        let url = URLBuilder().getCityToLatLongUrl(with: city)
        self.urlSession.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                if let coordinate = DataParser().parseCoordinates(from: data) {
                    if coordinate.name == city {
                        completion(.success((lat: coordinate.lat, lon: coordinate.lon)))
                    } else {
                        completion(.failure(.invalidCity))
                    }
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure(let error):
                print("Error = \(error)")
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
    func getWeatherReport(for lat: Double, lon: Double, cnt: Int, completion: @escaping (Result<WeatherReport, FetchWeatherErrors>) -> Void) {
        let url = URLBuilder().getWeatherReportURL(lat: lat, lon: lon, cnt: cnt)
        self.urlSession.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                if let result = DataParser().parseWeatherModel(from: data) {
                    completion(.success(result))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure(_):
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}
