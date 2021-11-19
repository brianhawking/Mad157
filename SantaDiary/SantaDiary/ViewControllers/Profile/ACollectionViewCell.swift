//
//  ACollectionViewCell.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/18/21.
//

import UIKit

class ACollectionViewCell: UICollectionViewCell {
    static let identifier = "ACollectionViewCell"
    
    var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        var isSelected = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.image = UIImage(named: SantaImages().avatar.randomElement()!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
