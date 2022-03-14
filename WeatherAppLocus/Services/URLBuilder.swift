//
//  URLBuilder.swift
//  WeatherAppLocus
//
//  Created by Shobhit Jain on 12/03/22.
//

import Foundation

struct URLBuilder {
    private let apiKey = "49f659bc0afdfc0742e1d699a2177df4"
    private let scheme = "http"
    private let host = "api.openweathermap.org"
    
    func getCityToLatLongUrl(with city: String) -> URL {
        let cityToLatLongPath = "/geo/1.0/direct"
        var urlBuilder = URLComponents()
        urlBuilder.scheme = scheme
        urlBuilder.host = host
        urlBuilder.path = cityToLatLongPath
        urlBuilder.queryItems = [
          URLQueryItem(name: "q", value: city),
          URLQueryItem(name: "limit", value: "1"),
          URLQueryItem(name: "appid", value: apiKey)
        ]
        let url = urlBuilder.url!
        print("URL for city = \(url)")
        return url
    }
    
    func getWeatherReportURL(lat: Double, lon: Double, cnt: Int) -> URL {
        let weatherReportPath = "/data/2.5/weather"
        var urlBuilder = URLComponents()
        urlBuilder.scheme = scheme
        urlBuilder.host = host
        urlBuilder.path = weatherReportPath
        urlBuilder.queryItems = [
          URLQueryItem(name: "lat", value: "\(lat)"),
          URLQueryItem(name: "lon", value: "\(lon)"),
          URLQueryItem(name: "appid", value: apiKey)
        ]
        let url = urlBuilder.url!
        print("URL for weather = \(url)")
        return url
    }
}
