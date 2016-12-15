//
//  CardCollectionViewCell.swift
//  Calculator2
//
//  Created by Alexander Lovato on 11/22/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

struct CardCollectionViewCellConst {
    static let reuseId = "CardCollectionViewCellId"
}

class CardCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // init setup
        
        self.contentView.backgroundColor = UIColor(hue: 63/360, saturation: 2/100, brightness: 96/100, alpha: 1)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "CalculatorViewController") as! CalculatorViewController
//        let cardViewSnapshot = vc.view.snapshotView(afterScreenUpdates: false)
//        cardViewSnapshot?.frame = self.bounds
//        cardViewSnapshot?.clipsToBounds = true
//        self.addSubview(cardViewSnapshot!)
//        self.layer.cornerRadius = 2
//        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("\(#function) unimplemented")
    }
}
