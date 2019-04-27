//
//  SentMemesCollectionViewController.swift
//  MemeMe 1.0
//
//  Created by Asmahero on ١٥ شعبان، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Asmahero. All rights reserved.
//

import Foundation
import UIKit
class SentMemesCollectionViewController: UICollectionViewController
{
 // MARK: Properties
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // Add it to the memes array in the Application Delegate
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /// to add a space between image collections
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    }

    // MARK: Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        collectionView?.reloadData()
    }
    // MARK: Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    // to assign the data of the cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // MemesCell has to be match with the storyboard collection view cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemesCell", for: indexPath) as! MemesCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
// to make the image of cell is memed image
         cell.memeImage?.image = meme.memedImage
        return cell
    }
// when I select the cell , it show me the details of the cell
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemesDetailViewController") as! MemesDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
