//
//  LocationService.swift
//  WeatherForecast
//
//  Created by PrabhuSelvaraj on 14/01/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {

    var manager: CLLocationManager
    
    var location: CLLocation?
    
    static let shared: LocationManager = LocationManager()
    
    var getCurrentLocation: CLLocation? {
        get {
            manager.location
        }
    }
    
    private override init() {
        manager = CLLocationManager()
        super.init()
        manager.delegate = self
    }
    
    func askforLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
    }
    
    func startListening() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = true
        manager.distanceFilter = 30
        manager.requestAlwaysAuthorization()
        DispatchQueue.global(qos: .background).async {
            if CLLocationManager.locationServicesEnabled() {
                self.manager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print(location)
            self.location = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
//        startListening()
        
        switch status {
        case .notDetermined, .restricted, .denied:
//            didChangeStatus?(false)
        break
            
        case .authorized, .authorizedWhenInUse, .authorizedAlways:
//            self.manager = CLLocationManager()
//            self.manager.delegate = self
            break
        default:
//            didChangeStatus?(true)
        break
        }
    }

    func getPlace(for coordinate: CLLocationCoordinate2D,
                  completion: @escaping (CLPlacemark?) -> Void) {
        self.getPlace(for: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude), completion: completion)
    }
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: Locale.current) { placemarks, error in
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }

            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }

            completion(placemark)
        }

    }
}

