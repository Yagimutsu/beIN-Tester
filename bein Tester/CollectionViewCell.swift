//
//  CollectionViewCell.swift
//  bein Tester
//
//  Created by Yagiz Ugur on 12.07.2019.
//  Copyright © 2019 Yagimutsu. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var selectionLabel :UILabel = {
        var label = UILabel()
        label.backgroundColor = .white
        label.text = "ITEM"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "SFProDisplay-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        
        //Shadow
        label.layer.shadowOffset = CGSize(width: 5,height: 5)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.53
        label.layer.shadowRadius = 5
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            
            selectionLabel.layer.borderWidth = 3.0
            selectionLabel.layer.borderColor = isSelected ? UIColor(red: 145/255, green: 71/255, blue: 224/255, alpha: 1).cgColor : UIColor.clear.cgColor
            selectionLabel.textColor = isSelected ? UIColor(red: 145/255, green: 71/255, blue: 224/255, alpha: 1) : UIColor.black
            
        }
        
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(selectionLabel)
        
        
        selectionLabel.translatesAutoresizingMaskIntoConstraints = false
        selectionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        selectionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        selectionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        selectionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
