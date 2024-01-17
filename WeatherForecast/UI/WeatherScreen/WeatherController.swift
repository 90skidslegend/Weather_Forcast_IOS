//
//  WeatherController.swift
//  WeatherForecast
//
//  Created by Sanjeev on 14/01/24.
//

import Foundation
import UIKit
import RxSwift
import AVFoundation

class WeatherController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    var weatherTableCells: [UserWeatherDetailsCell] = []
    var weatherDetails: Weather?
    var forecastList: ForecastList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register Table View Cells And Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ImageContentCell", bundle: nil), forCellReuseIdentifier: "ImageContentCell")
        tableView.register(UINib(nibName: "ListContentCell", bundle: nil), forCellReuseIdentifier: "ListContentCell")
        tableView.register(UINib(nibName: "WeatherListCell", bundle: nil), forCellReuseIdentifier: "WeatherListCell")
        // APi Calls
        self.setupApi()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.overrideUserInterfaceStyle = .dark
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension WeatherController {
    func setupApi() {
        self.getCurrentWeatherDetails()
        self.getForecastListDetails()
    }
}

// MARK: TableView Lifecycle
extension WeatherController: UITableViewDataSource, UITabBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.weatherTableCells = [.image, .humidity, .sunrise, .sunset, .weatherList]
        return self.weatherTableCells.count
    }
    
    // swiftlint:disable:next function_body_length
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.weatherTableCells[indexPath.row] {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageContentCell", for: indexPath) as! ImageContentCell
            if let weatherDetails = self.weatherDetails {
                cell.setupData(weatherData: weatherDetails)
            }
            cell.nextTapped = {
                let storyboard = UIStoryboard(name: "WeatherExploreScreen", bundle: nil)
                let weatherController = storyboard.instantiateViewController(withIdentifier: "WeatherExploreScreen") as! WeatherExploreScreen
                self.present(weatherController, animated: true)
            }
            return cell
        case .humidity:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListContentCell", for: indexPath) as! ListContentCell
            if let weatherDetails = self.weatherDetails {
                cell.setupData(title: "Humidity", value: String(weatherDetails.tempDetails.humidity))
            }
            return cell
        case .sunrise:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListContentCell", for: indexPath) as! ListContentCell
            if let weatherDetails = self.weatherDetails {
                cell.setupData(title: "Sunrise", value: convertUNIXTimeStampToDateTime(timestamp: TimeInterval(weatherDetails.weatherSYSData.sunrise)))
            }
            return cell
        case .sunset:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListContentCell", for: indexPath) as! ListContentCell
            if let weatherDetails = self.weatherDetails {
                cell.setupData(title: "Sunset", value: convertUNIXTimeStampToDateTime(timestamp: TimeInterval(weatherDetails.weatherSYSData.sunset)))
            }
            return cell
        case .weatherList:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell", for: indexPath) as! WeatherListCell
            if let forecastList = self.forecastList {
                cell.setupData(forecastList: forecastList)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.weatherTableCells[indexPath.row] {
        case .image:
            return getFullScreenHeight() - getFullScreenHeight() / 2
        case .humidity:
            return 60
        case .sunrise:
            return 60
        case .sunset:
            return 60
        case .weatherList:
            return 250
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: API Calls
extension WeatherController {
    private func getCurrentWeatherDetails() {
        ContentNetworkManager.getWeatherDetails(latitude: getUserCurrentLocation().coordinate.latitude, longitude: getUserCurrentLocation().coordinate.longitude).subscribe(onNext: { [weak self] response in
            self?.weatherDetails = response
            self?.tableView.reloadData()
        }, onError: { error in
            print(error)
            self.showErrorPopup(message: error.localizedDescription)
        }, onDisposed: {
        }).disposed(by: self.bag)
    }
    
    private func getForecastListDetails() {
        ContentNetworkManager.getForecastDetails(latitude: getUserCurrentLocation().coordinate.latitude, longitude: getUserCurrentLocation().coordinate.longitude).subscribe(onNext: { [weak self] response in
            self?.forecastList = response
            self?.tableView.reloadData()
        }, onError: { error in
            print(error)
            self.showErrorPopup(message: error.localizedDescription)
        }, onDisposed: {
        }).disposed(by: self.bag)
    }
}

// MARK: Enum
enum UserWeatherDetailsCell: Int {
    case image, humidity, sunrise, sunset, weatherList
}


extension WeatherController {
    func showErrorPopup(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
