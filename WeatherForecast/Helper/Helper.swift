//
//  Helper.swift
//  WeatherForecast
//
//  Created by Sanjeev on 14/01/24.
//

import Foundation
import UIKit
import RxSwift
import CoreLocation

func setRootController(_ viewController: UIViewController?) {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = windowScene.windows.first {
        window.rootViewController = viewController
    }
}

func getFullScreenHeight() -> CGFloat {
    let screenBounds = UIScreen.main.bounds
    let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
    let fullHeight = screenBounds.height - (safeAreaInsets?.top ?? 0) - (safeAreaInsets?.bottom ?? 0)
    return fullHeight
}

func getUserCurrentLocation() -> CLLocation {
    if let loc = LocationManager.shared.getCurrentLocation {
        return loc
    } else if let loc = LocationManager.shared.location {
        return loc
    } else if let loc = CLLocationManager().location {
        return loc
    }
    let defaultLocation = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    let location = CLLocation(latitude: defaultLocation.latitude, longitude: defaultLocation.longitude)
    return location
}

func convertKelvinToCelsius(_ kelvin: Double) -> Double {
    let roundedNumber = round((kelvin - 273.15) * 10000) / 10000
    return roundedNumber
}

func convertUNIXTimeStampToDateTime(timestamp: TimeInterval) -> String {
//    let timestamp: TimeInterval = 1705418403
    // Create a DateFormatter instance
    let dateFormatter = DateFormatter()
    // Set the date format you desire
    dateFormatter.dateFormat = "EEEE dd HH:mm a"
    // Convert the timestamp to a Date object
    let date = Date(timeIntervalSince1970: timestamp)

    // Format the date as a string
    let formattedDate = dateFormatter.string(from: date)
    return formattedDate
}

func getGreeting(for timestamp: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: timestamp)
    
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    
    switch hour {
    case 0..<12:
        return "Happy Morning!.."
    case 12..<18:
        return "Good Afternoon!.."
    default:
        return "Bliss Night!.."
    }
}

func dateFormatter(dateTime: Int) -> String {
    // UTC timestamp
    // 1661871600
    let utcTimestamp = TimeInterval(dateTime)

    // Create a Date object from the UTC timestamp
    let utcDate = Date(timeIntervalSince1970: utcTimestamp)

    // Create a DateFormatter
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")

    // Convert UTC date to string (optional)
    let utcDateString = dateFormatter.string(from: utcDate)
    print("UTC Date: \(utcDateString)")

    // Convert UTC date to IST
    dateFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata") // IST timezone
    let istDateString = dateFormatter.string(from: utcDate)
    print("IST Date: \(istDateString)")
    return istDateString
}

