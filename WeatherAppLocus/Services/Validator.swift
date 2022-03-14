//
//  Validator.swift
//  WeatherAppLocus
//
//  Created by Shobhit Jain on 12/03/22.
//

import Foundation

struct Validator {
    func isValidateCityInput(with city: String) -> Bool {
        if city.isEmpty {
            return false
        }
        return true
    }
}
