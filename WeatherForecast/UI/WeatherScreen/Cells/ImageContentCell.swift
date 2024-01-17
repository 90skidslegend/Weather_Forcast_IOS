//
//  ImageContentCell.swift
//  WeatherForecast
//
//  Created by Sanjeev on 14/01/24.
//

import Foundation
import UIKit

class ImageContentCell: UITableViewCell {
    @IBOutlet weak var mainStackView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
        
    // Callbacks
    var imageTapped: (() -> Void)?
    var nextTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
}

extension ImageContentCell {
    func setupUI() {
        self.mainStackView.layer.cornerRadius = 5
        self.weatherImage.layer.cornerRadius = 5
        self.mainStackView.layer.borderWidth = 1
        self.mainStackView.layer.borderColor = UIColor.white.cgColor
    }
    
    func setupData(weatherData: Weather) {
        let celsiusTemperature = convertKelvinToCelsius(weatherData.tempDetails.temp)
        self.celciusLabel.text = "\(celsiusTemperature)°C"
        self.timeLabel.text = convertUNIXTimeStampToDateTime(timestamp: TimeInterval(weatherData.dateTime))
        self.modeLabel.text = weatherData.weatherDetails.first?.main
//        self.weatherImage.image = UIImage(systemName: "systemImage")
        self.titleLabel.text = getGreeting(for: TimeInterval(weatherData.dateTime))
    }
    
    @IBAction func nextScreenTapped(_ sender: UIButton) {
        self.nextTapped?()
    }
}
