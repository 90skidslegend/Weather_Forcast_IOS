//
//  ForecastList.swift
//  WeatherForecast
//
//  Created by Sanjeev on 15/01/24.
//

import Foundation
import SwiftyJSON

class ForecastList {
    var list = [Weather]()
    
    required init(_ json: JSON) {
        if let array = json["list"].array {
            for result in array {
                self.list.append(Weather(result))
            }
        }
    }
}

class CurrentLocationDetails {
    var zip: String
    var name: String
    var latitude: Double = 0
    var longitude: Double = 0
    var country: String
    
    required init(_ json: JSON) {
        self.zip = json["zip"].stringValue
        self.name = json["name"].stringValue
        self.latitude = json["lat"].doubleValue
        self.longitude = json["lon"].doubleValue
        self.country = json["country"].stringValue
    }
}
