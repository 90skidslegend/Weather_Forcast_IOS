//
//  ContentManager.swift
//  WeatherForecast
//
//  Created by PrabhuSelvaraj on 14/01/24.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import RxSwift
import CoreLocation

class ContentNetworkManager: NSObject {
    static let manager = Session.default
    static let weatherMandatoryPart = "https://api.openweathermap.org/data/2.5/weather"
    static let forecastMandatoryPart = "https://api.openweathermap.org/data/2.5/forecast"
    static let forecastLatLongMandatoryPart = "https://api.openweathermap.org/geo/1.0/zip"
    
//    "http://api.openweathermap.org/geo/1.0/zip?zip=600100,IN&appid=88a0b257bcbc39ca9afe6dfccd208de9"
    
    class func getWeatherDetails(latitude: Double, longitude: Double) -> Observable<Weather> {
        var params = [String: Any]()
        params["lat"] = String(format: "%.7f", latitude)
        params["lon"] = String(format: "%.7f", longitude)
        params["appid"] = weatherApiKey
        return manager.rx
            .netRequest(.get, weatherMandatoryPart, parameters: params,
                        encoding: URLEncoding(destination: .queryString))
            .map { _, json in
                return Weather(json)
            }
    }
    
    class func getForecastDetails(latitude: Double, longitude: Double) -> Observable<ForecastList> {
        var params = [String: Any]()
        params["lat"] = String(format: "%.7f", latitude)
        params["lon"] = String(format: "%.7f", longitude)
        params["appid"] = weatherApiKey
        return manager.rx
            .netRequest(.get, forecastMandatoryPart, parameters: params,
                        encoding: URLEncoding(destination: .queryString))
            .map { _, json in
                return ForecastList(json)
            }
    }
    
    class func getLatLongFromZipCode(zipcode: Int = 600100, country: String = "IN") -> Observable<CurrentLocationDetails> {
        var params: [String: Any] = [
            "zip": "\(zipcode),IN",
            "appid": weatherApiKey
        ]
        return manager.rx
            .netRequest(.get, forecastLatLongMandatoryPart, parameters: params,
                        encoding: URLEncoding(destination: .queryString))
            .map { _, json in
                return CurrentLocationDetails(json)
            }
    }
}

enum WeatherImageRepresentation: String {
    case dayCloudy, dayPartlyCloudy, sunny, rainy, nightClear, nightCloudy, nightPartlyCloudy
    var stringValue: String {
        return self.rawValue
    }
}
