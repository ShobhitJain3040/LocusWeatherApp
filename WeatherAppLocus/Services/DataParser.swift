//
//  DataParser.swift
//  WeatherAppLocus
//
//  Created by Shobhit Jain on 13/03/22.
//

import Foundation

struct DataParser {
    func parseCoordinates(from data: Data) -> (lat: Double, lon: Double, name: String)? {
        let jsonArray = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]]
        if let json = jsonArray?.first, let name = json["name"] as? String, let lat = json["lat"] as? Double, let lon = json["lon"] as? Double {
            return (lat, lon, name)
        }
        return nil
    }
    
    func parseWeatherModel(from data: Data) -> WeatherReport? {
        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
        if let dic = json {
            var report = WeatherReport()
            if let main = dic["main"] as? [String: Any] {
                if let temp = main["temp"] as? Double {
                    report.temp = "\(temp)"
                }
                if let feelsLike = main["feels_like"] as? Double {
                    report.feelsLike = "\(feelsLike)"
                }
            }
            if let weatherList = dic["weather"] as? [[String: Any]], let weather = weatherList.first {
                if let title = weather["main"] as? String {
                    report.mainTitle = title
                }
                if let description = weather["description"] as? String {
                    report.description = description
                }
            }
            return report
        }
        return nil
    }
}
