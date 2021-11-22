//
//  DatePickerTableViewCell.swift
//  ProfileSetup
//
//  Created by Vincent Cubit on 11/21/21.
//


import UIKit


class DatePickerTableViewCell: UITableViewCell {
    
    
    static let id = "DatePickerTableViewCell"

    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .systemGray
        label.text = "Birthday"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let date: UIDatePicker = {
        let date = UIDatePicker()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.datePickerMode = .date
        date.isUserInteractionEnabled = false
        return date
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.birthdayLabel)
        self.contentView.addSubview(self.date)
        
        
        let constraints: [ NSLayoutConstraint ] = [
            self.birthdayLabel.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor, constant: 10),
            self.birthdayLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.date.rightAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.rightAnchor, constant: -50),
            self.date.centerYAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerYAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    

}


