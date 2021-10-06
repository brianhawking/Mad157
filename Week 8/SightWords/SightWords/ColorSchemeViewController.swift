//
//  ColorSchemeViewController.swift
//  SightWords
//
//  Created by Brian Veitch on 10/6/21.
//

import UIKit

class ColorSchemeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewAccessibilityDelegate {

    @IBOutlet weak var colorPicker: UIPickerView!
    @IBOutlet weak var cardView: UIView!
    
    // get colors
    var colors = ColorScheme()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get current color scheme
        colors.load()
        currentIndex = colors.index
        colorPicker.delegate = self
        colorPicker.dataSource = self
        colorPicker.selectRow(colors.index, inComponent: 0, animated: true)
        setupCard()

        // Do any additional setup after loading the view.
    }
    
    func setupCard() {
        cardView.layer.backgroundColor = colors.styles[colors.index].cardBackground.cgColor
        cardView.layer.cornerRadius =  30
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cardView.layer.shadowOpacity = 0.8
        cardView.layer.shadowRadius = 10
        
        cardView.backgroundColor = colors.styles[colors.index].cardBackground
        self.view.backgroundColor = colors.styles[colors.index].viewBackground
    
    }
    
    func updateView(row: Int) {
        
        cardView.layer.backgroundColor = colors.styles[row].cardBackground.cgColor
        cardView.layer.cornerRadius =  30
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cardView.layer.shadowOpacity = 0.8
        cardView.layer.shadowRadius = 10
        
        self.view.backgroundColor = colors.styles[row].viewBackground
    
        colorPicker.setValue(UIColor.red, forKey: "textColor")
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        colors.save(index: currentIndex)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: "Style \(row+1)", attributes: [NSAttributedString.Key.foregroundColor: colors.styles[currentIndex].textColor])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.styles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Styles \(row+1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        updateView(row: row)
        currentIndex = row
        
    }
    
}
