//
//  WeatherListCell.swift
//  WeatherForecast
//
//  Created by Sanjeev on 15/01/24.
//

import Foundation
import UIKit

class WeatherListCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var forecastList: ForecastList?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
}

extension WeatherListCell {
    func setupUI() {
        self.imageCollectionView.register(UINib(nibName: "WeatherListCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WeatherListCollectionCell")
//        self.imageCollectionView.register(WeatherListCollectionCell.self, forCellWithReuseIdentifier: "WeatherListCollectionCell")
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.layer.cornerRadius = 5
    }
    
    func setupData(forecastList: ForecastList) {
        self.forecastList = forecastList
        self.imageCollectionView.reloadData()
    }
    
    @IBAction func nextScreenTapped(_ sender: UIButton) {
    }
}

extension WeatherListCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.forecastList?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherListCollectionCell", for: indexPath) as! WeatherListCollectionCell
        if self.forecastList?.list.count ?? 0 > indexPath.row, let weatherObj = self.forecastList?.list[indexPath.row] {
            cell.setupDetails(data: weatherObj)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension WeatherListCell: UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 200)
    }
}
