//
//  TextInputCell.swift
//  WeatherForecast
//
//  Created by PrabhuSelvaraj on 15/01/24.
//

import Foundation
import UIKit

class TextInputCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.delegate = self
        }
    }
    // Callbacks
    var onChangeText: ((String) -> Void)?
    var onSearchTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
}

extension TextInputCell {
    func setupUI() {
        self.textView.layer.cornerRadius = 5
        self.textView.layer.borderWidth = 1
        self.textView.layer.borderColor = UIColor.white.cgColor
        self.textView.keyboardType = .numberPad
    }
    
    @IBAction func searchTapped(_ sender: UIButton) {
        self.onSearchTapped?()
    }
}

extension TextInputCell: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        onChangeText?(textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}
