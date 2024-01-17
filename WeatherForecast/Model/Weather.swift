//
//  Weather.swift
//  WeatherForecast
//
//  Created by Sanjeev on 14/01/24.
//

import Foundation
import SwiftyJSON

class Weather {
    var coordinates: Coordinates
    var weatherDetails = [WeatherDetails]()
    var name: String
    var tempDetails: TempDetails
    var timeZone: Int
    var istDate: Date?
    var weatherSYSData: WeatherSYSData
    var dateTime: Int
    
//    public init() {}
    
    required init(_ json: JSON) {
        self.coordinates = Coordinates(json["coord"])
        if let array = json["weather"].array {
            for result in array {
                self.weatherDetails.append(WeatherDetails(result))
            }
        }
        self.name = json["name"].stringValue
        self.tempDetails = TempDetails(json["main"])
        self.timeZone = json["timezone"].intValue
        self.weatherSYSData = WeatherSYSData(json["sys"])
        self.dateTime = json["dt"].intValue
    }
}

class Coordinates {
    var latitude: Double
    var longitude: Double
    
    required init(_ json: JSON) {
        self.latitude = json["lat"].doubleValue
        self.longitude = json["lon"].doubleValue
    }
}

class WeatherDetails {
    var id: Int
    var main: String
    var description: String
    var icon: String
    var conditionName: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    required init(_ json: JSON) {
        self.id = json["id"].intValue
        self.main = json["main"].stringValue
        self.description = json["description"].stringValue
        self.icon = json["icon"].stringValue
    }
}

class WeatherSYSData {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
    var sunriseString: String {
        return getTimeString(time: sunrise)
    }
    
    var sunsetString: String {
        return getTimeString(time: sunset)
    }
    
    required init(_ json: JSON) {
        self.type = json["type"].intValue
        self.id = json["id"].intValue
        self.country = json["country"].stringValue
        self.sunrise = json["sunrise"].intValue
        self.sunset = json["sunset"].intValue
    }
    
    
    func getTimeString(time: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(time))
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "IST")!
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let result = ("\(hour):\(minutes)")
        return result
    }
}

class TempDetails {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
    var sea_level: Double
    var grnd_level: Double

    var minTemperatureString: String {
        return String(format: "%.0f", temp_min)
    }
    
    var maxTemperatureString: String {
        return String(format: "%.0f", temp_max)
    }
    
    required init(_ json: JSON) {
        self.temp = json["temp"].doubleValue
        self.feels_like = json["feels_like"].doubleValue
        self.temp_max = json["temp_max"].doubleValue
        self.temp_min = json["temp_min"].doubleValue
        self.pressure = json["pressure"].doubleValue
        self.humidity = json["humidity"].doubleValue
        self.sea_level = json["sea_level"].doubleValue
        self.grnd_level = json["grnd_level"].doubleValue
    }
}
