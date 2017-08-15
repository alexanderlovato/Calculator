//
//  CardLayout.swift
//  CardCollectionView
//
//  Created by Alexander Lovato on 1/18/17.
//  Copyright © 2017 Nonsense. All rights reserved.
//

import UIKit

struct CardLayoutConst {
    static let maxYOffset: CGFloat = -10
    static let minZoomLevel: CGFloat = 0.9
    static let minAlpha: CGFloat = 0.5
}

class CardLayout: UICollectionViewFlowLayout {
    
    private var deletedIndexPaths: [IndexPath] = []
    private var insertedIndexPaths: [IndexPath] = []
    
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // init setup
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.itemSize = CGSize(width: 282, height: 428)
    }
    
    
    // MARK: -
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAtts = super.layoutAttributesForElements(in: rect) else { return nil }
        
        // we copy layout attributes here to avoid collection view cache diff warning
        let modifiedLayoutAtts = Array(NSArray(array: layoutAtts, copyItems: true)) as! [UICollectionViewLayoutAttributes]
        let visibleRect = CGRect(origin: self.collectionView!.contentOffset, size: self.collectionView!.bounds.size)
        let activeWidth = self.collectionView!.bounds.size.width
        
        // adjust zoom of each cell so that the center cell is at 1x, while surrounding cells are as low as 0.9x depending on distance from center
        for attributes in modifiedLayoutAtts {
            if attributes.frame.intersects(visibleRect) {
                let distance = visibleRect.midX - attributes.center.x
                let normalDistance = distance / activeWidth
                if (abs(distance) < activeWidth) {
                    
                    // translate
                    let yOffset = CardLayoutConst.maxYOffset * (1-abs(normalDistance))
                    let offsetTransform = CATransform3DMakeTranslation(0, yOffset, 0)
                    
                    // scale
                    let zoom = CardLayoutConst.minZoomLevel + (1-CardLayoutConst.minZoomLevel)*(1-abs(normalDistance))
                    attributes.transform3D = CATransform3DScale(offsetTransform, zoom, zoom, 1)
                    attributes.zIndex = 1
                    
                    // opacity
                    let alpha = CardLayoutConst.minAlpha + (1-CardLayoutConst.minAlpha)*(1-abs(normalDistance))
                    attributes.alpha = alpha
                }
            }
        }
        
        return modifiedLayoutAtts
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        insertedIndexPaths.removeAll(keepingCapacity: false)
        deletedIndexPaths.removeAll(keepingCapacity: false)
        
        for update in updateItems {
            switch update.updateAction {
            case.insert:
                insertedIndexPaths.append(update.indexPathAfterUpdate!)
            case.delete:
                deletedIndexPaths.append(update.indexPathBeforeUpdate!)
            default:
                return
            }
        }
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        
        insertedIndexPaths.removeAll(keepingCapacity: false)
        deletedIndexPaths.removeAll(keepingCapacity: false)
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath)
        attributes?.transform = CGAffineTransform.init(translationX: 0, y: -400)
        attributes?.alpha = 0.0
        return attributes
    }

}
