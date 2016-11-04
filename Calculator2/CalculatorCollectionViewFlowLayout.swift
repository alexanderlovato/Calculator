//
//  CalculatorCollectionViewFlowLayout.swift
//  Calculator2
//
//  Created by Alexander Lovato on 11/3/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class CalculatorCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        var offsetAdjustment = MAXFLOAT
        let horizontalOffset = proposedContentOffset.x + (self.collectionView!.bounds.size.width - self.itemSize.width)
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: self.collectionView!.bounds.size.width, height: self.collectionView!.bounds.size.height)
        
        let array = super.layoutAttributesForElements(in: targetRect)
        
        for layoutAttributes in array! {
            let itemOffset = layoutAttributes.frame.origin.x;
            if (fabsf(Float(itemOffset - horizontalOffset)) < fabsf(offsetAdjustment)) {
                offsetAdjustment = Float(itemOffset - horizontalOffset)
            }
        }
        
        let offsetX = Float(proposedContentOffset.x) + offsetAdjustment
        return CGPoint(x: CGFloat(offsetX), y: proposedContentOffset.y)
    }

}
