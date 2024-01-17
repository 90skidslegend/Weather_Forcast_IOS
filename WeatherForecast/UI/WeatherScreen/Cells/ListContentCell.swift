//
//  ListContentCell.swift
//  WeatherForecast
//
//  Created by Sanjeev on 14/01/24.
//

import Foundation
import UIKit

class ListContentCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var supportView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
}

extension ListContentCell {
    func setupUI() {
        self.supportView.layer.cornerRadius = 5
    }
    
    func setupData(title: String, value: String) {
        self.title.text = title
        self.value.text = value
    }
    
    @IBAction func nextScreenTapped(_ sender: UIButton) {
    }
}
