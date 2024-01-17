//
//  SplashScreenController.swift
//  WeatherForecast
//
//  Created by Sanjeev on 14/01/24.
//

import Foundation
import UIKit
import AuthenticationServices

class SplashScreenController: UIViewController {
}

// MARK: - LifeCycle
extension SplashScreenController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        // Instantiate Initial View Controller
        let storyboard = UIStoryboard(name: "WeatherController", bundle: nil)
        let weatherController = storyboard.instantiateViewController(withIdentifier: "WeatherController") as! WeatherController
        setRootController(weatherController)
    }
}
