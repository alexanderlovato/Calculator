//
//  NavigationViewController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 11/22/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    var statusBarStyle = UIStatusBarStyle.default
    
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
