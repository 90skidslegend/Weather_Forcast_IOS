//
//  WeatherExploreScreen.swift
//  WeatherForecast
//
//  Created by Sanjeev on 15/01/24.
//

import Foundation
import UIKit
import RxSwift
import AVFoundation

class WeatherExploreScreen: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    private let bag = DisposeBag()
    var weatherTableCells: [WeatherExploreEnum] = []
    var weatherDetails: Weather?
    var forecastList: ForecastList?
    var latLongDetails: CurrentLocationDetails?
    var zipcode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ImageContentCell", bundle: nil), forCellReuseIdentifier: "ImageContentCell")
        tableView.register(UINib(nibName: "ListContentCell", bundle: nil), forCellReuseIdentifier: "ListContentCell")
        tableView.register(UINib(nibName: "WeatherListCell", bundle: nil), forCellReuseIdentifier: "WeatherListCell")
        tableView.register(UINib(nibName: "TextInputCell", bundle: nil), forCellReuseIdentifier: "TextInputCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension WeatherExploreScreen {
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: TableView Lifecycle
extension WeatherExploreScreen: UITableViewDataSource, UITabBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.weatherTableCells = []
        self.weatherTableCells = [.userInput]
        if let _ = self.weatherDetails {
            self.weatherTableCells.append(.exploreDetails)
        }
        if !(self.forecastList?.list.isEmpty ?? true) {
            self.weatherTableCells.append(.weatherList)
        }
        return self.weatherTableCells.count
    }
    
    // swiftlint:disable:next function_body_length
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.weatherTableCells[indexPath.row] {
        case .userInput:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputCell", for: indexPath) as! TextInputCell
            cell.onChangeText = { value in
                self.zipcode = value
            }
            cell.onSearchTapped = {
                self.getLatLongFromZipCode(zipcode: Int(self.zipcode) ?? 0)
            }
            return cell
        case .exploreDetails:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageContentCell", for: indexPath) as! ImageContentCell
            if let weatherDetails = self.weatherDetails {
                cell.setupData(weatherData: weatherDetails)
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
        case .userInput:
            return 95
        case .exploreDetails:
            return getFullScreenHeight() - getFullScreenHeight() / 2
        case .weatherList:
            return 250
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: Api Calls
extension WeatherExploreScreen {
    private func getWeatherDetails() {
        if let lat = self.latLongDetails?.latitude, let long = self.latLongDetails?.longitude {
            ContentNetworkManager.getWeatherDetails(latitude: lat, longitude: long).subscribe(onNext: { [weak self] response in
                self?.weatherDetails = response
                self?.tableView.reloadData()
            }, onError: { error in
                print(error)
            }, onDisposed: {
            }).disposed(by: self.bag)
        }
    }
    
    private func getLatLongFromZipCode(zipcode: Int) {
        ContentNetworkManager.getLatLongFromZipCode(zipcode: zipcode).subscribe(onNext: { [weak self] response in
            if response.latitude != 0, response.longitude != 0 {
                self?.latLongDetails = response
                self?.getForecastListDetails()
                self?.getWeatherDetails()
            }
        }, onError: { error in
            self.showErrorPopup(message: error.localizedDescription)
            print(error)
        }, onDisposed: {
        }).disposed(by: self.bag)
    }
    
    private func getForecastListDetails() {
        if let lat = self.latLongDetails?.latitude, let long = self.latLongDetails?.longitude {
            ContentNetworkManager.getForecastDetails(latitude: lat, longitude: long).subscribe(onNext: { [weak self] response in
                self?.forecastList = response
                self?.tableView.reloadData()
            }, onError: { error in
                self.showErrorPopup(message: error.localizedDescription)
                print(error)
            }, onDisposed: {
            }).disposed(by: self.bag)
        }
    }
}

extension WeatherExploreScreen {
    func showErrorPopup(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: Enum
enum WeatherExploreEnum: Int {
    case userInput, exploreDetails, weatherList
}
