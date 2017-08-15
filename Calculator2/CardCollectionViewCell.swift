//
//  CardCollectionViewCell.swift
//  CardCollectionView
//
//  Created by Alexander Lovato on 1/18/17.
//  Copyright © 2017 Nonsense. All rights reserved.
//

import UIKit

struct CardCollectionViewCellConst {
    static let reuseId = "CardCollectionViewCellId"
}

class CardCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // init setup
        
        self.contentView.addSubview(imageView)
        imageView.frame = self.bounds
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) unimplemented")
    }
}
