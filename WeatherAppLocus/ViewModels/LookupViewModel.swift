//
//  LookupViewModel.swift
//  WeatherAppLocus
//
//  Created by Shobhit Jain on 12/03/22.
//

import Foundation
import UIKit

class LookupViewModel {
    var showLoader: Box<Bool>
    var service = WeatherService(session: URLSession.shared)
    var validator = Validator()
    
    init() {
        showLoader = Box(false)
    }
    
    func getWeather(for city: String, with completionHandler: @escaping (Result<WeatherReport, FetchWeatherErrors>) -> Void) {
        guard  validator.isValidateCityInput(with: city) else {
            completionHandler(.failure(.invalidInput))
            return
        }
        self.showLoader.value = true
        service.getLatitudeAndLongitude(of: city) { result in
            DispatchQueue.main.async {
                self.showLoader.value = false
                switch result {
                case .success(let coordinates):
                    self.getWeather(lat: coordinates.lat, lon: coordinates.lon, completion: completionHandler)
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        }
    }
    
    
    private func getWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherReport, FetchWeatherErrors>) -> Void) {
        self.showLoader.value = true
        service.getWeatherReport(for: lat, lon: lon, cnt: 20) { result in
            DispatchQueue.main.async {
                self.showLoader.value = false
                switch result {
                case .success(let reports):
                    completion(.success(reports))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
