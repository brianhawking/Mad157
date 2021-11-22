//
//  TextFieldTableViewCell.swift
//  ProfileSetup
//
//  Created by Vincent Cubit on 11/21/21.
//


import UIKit


class TextFieldTableViewCell: UITableViewCell, UITextFieldDelegate {

   
    static let id = "TextFieldTableViewCell"
    
    
    private let field: UITextField = {
        let field = UITextField()
        field.placeholder = "Name"
        field.returnKeyType = .done
        field.font = UIFont.systemFont(ofSize: 22)
        return field
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.field)
        self.field.delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.field.frame = CGRect(x: 30, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    

}

