//
//  MultiTaskingCollectionViewController.swift
//  Calculator2
//
//  Created by Alexander Lovato on 11/3/16.
//  Copyright © 2016 Nonsense. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ScreenshotCell"

class MultiTaskingCollectionViewController: UICollectionViewController {
    
    let pomAppCount = 20
    
    @IBOutlet weak var screenshotsCollectionView: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let screenSize = UIScreen.main.bounds
        
        let screenshotsCollectionViewFlowLayout = screenshotsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        screenshotsCollectionViewFlowLayout.itemSize = CGSize(width: 1, height: 1)
        screenshotsCollectionViewFlowLayout.minimumInteritemSpacing = 0.0
        screenshotsCollectionViewFlowLayout.minimumLineSpacing = 20.0
        let screenshotsSectionInset = screenSize.width / 4.0
        screenshotsCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0.0, screenshotsSectionInset, 0.0, screenshotsSectionInset)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let screenshotsCollectionViewFlowLayout = screenshotsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        screenshotsCollectionViewFlowLayout.minimumLineSpacing += screenshotsCollectionViewFlowLayout.itemSize.width
        
        if scrollView == screenshotsCollectionView {
            scrollView.contentOffset.x -= scrollView.frame.origin.x
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pomAppCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if collectionView == screenshotsCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) 
        }
        
        let hue = CGFloat(indexPath.item) / CGFloat(pomAppCount)
        cell.backgroundColor = UIColor(hue: hue, saturation: 1, brightness: 1, alpha: 1)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
