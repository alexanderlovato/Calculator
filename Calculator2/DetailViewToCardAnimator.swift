//
//  DetailViewToCardAnimator.swift
//  CardCollectionView
//
//  Created by Alexander Lovato on 1/18/17.
//  Copyright © 2017 Nonsense. All rights reserved.
//

import UIKit

class DetailViewToCardAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        guard toViewController is CardCollectionViewController else { fatalError("\(String(describing: self))) should only be used to transition to card view") }
        let cardController = toViewController as! CardCollectionViewController
        let cardFrame = cardController.beginFrameForTransition()
        let cardView = cardController.viewForTransition()
        let cardViewSnapshot = fromViewController.view.snapshotView(afterScreenUpdates: false)
        
        // match corner radius to target views
//        cardView.isHidden = true
        cardViewSnapshot?.layer.cornerRadius = cardView.layer.cornerRadius
        cardViewSnapshot?.clipsToBounds = true
        cardViewSnapshot?.frame = fromViewController.view.bounds
        
        // add required view to context
        transitionContext.containerView.addSubview(toViewController.view)
        transitionContext.containerView.addSubview(cardViewSnapshot!)
        
        // animate
        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 11,
            options: [],
            animations: {
                cardViewSnapshot?.frame = cardFrame
            }, completion: { _ in
                
                // finish animation and transition
//                cardView.isHidden = false
                cardViewSnapshot?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
        })
    }
}











