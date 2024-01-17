//
//  WeatherListCollectionCell.swift
//  WeatherForecast
//
//  Created by Sanjeev on 15/01/24.
//

import Foundation
import UIKit
import RxSwift

class WeatherListCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var mainStackView: UIView!
    @IBOutlet weak var seperatorViewTop: UIView!
    @IBOutlet weak var seperatorViewBottom: UIView!
    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabbeel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension WeatherListCollectionCell {
    private func setupUI() {
        self.mainStackView.layer.cornerRadius = 5
        self.mainStackView.layer.borderWidth = 1
        self.mainStackView.layer.borderColor = UIColor.white.cgColor
        self.layoutIfNeeded()
    }
    
    func setupDetails(data: Weather) {
        let celsiusTemperature = convertKelvinToCelsius(data.tempDetails.temp)
        self.celciusLabel.text = "\(celsiusTemperature)°C"
        self.timeLabel.text = convertUNIXTimeStampToDateTime(timestamp: TimeInterval(data.dateTime))
        self.weatherLabbeel.text = data.weatherDetails.first?.main
        self.humidityLabel.text = "Humidity: \(data.tempDetails.humidity)"
        self.tempLabel.text = data.weatherDetails.first?.description
    }
}
