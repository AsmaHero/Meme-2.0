//
//  MemesDetailViewController.swift
//  MemeMe 1.0
//
//  Created by Asmahero on ١٦ شعبان، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Asmahero. All rights reserved.
//

import Foundation
import UIKit
class MemesDetailViewController: UIViewController {
    

    // MARK: Properties
    
    var meme: Meme!
    
    // MARK: Outlets
    
   @IBOutlet weak var imageView: UIImageView!
  //  @IBOutlet weak var label: UILabel!
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
       self.imageView!.image = meme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }


}
