//
//  NavigationViewController.swift
//  CardCollectionView
//
//  Created by Alexander Lovato on 1/18/17.
//  Copyright © 2017 Nonsense. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    var statusBarStyle = UIStatusBarStyle.lightContent
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        // keep status bar updated
        updateStatusBarForTopViewController()
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let vc = super.popViewController(animated: animated)
        // keep status bar updated
        updateStatusBarForTopViewController()
        return vc
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        let vcs = super.popToRootViewController(animated: animated)
        // keep status bar updated
        updateStatusBarForTopViewController()
        return vcs
    }
    
    private func updateStatusBarForTopViewController() {
        if let top = self.topViewController {
            statusBarStyle = top.preferredStatusBarStyle
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

}
