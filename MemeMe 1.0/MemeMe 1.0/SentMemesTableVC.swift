//
//  SentMemesTableVC.swift
//  MemeMe 1.0
//
//  Created by Asmahero on ١٥ شعبان، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Asmahero. All rights reserved.
//

import Foundation
import UIKit
class sentMemesTableVC: UITableViewController 
{
     // MARK: Properties
   var meme: Meme!
    
  // Add it to the memes array in the Application Delegate
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    // Add it to the memes array in the Application Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
    }
     // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
       // MARK: Table View Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          // MemeTableCell has to be match with the storyboard collection view cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // to set the title label and image in the left
        cell.textLabel?.text = "\(meme.top) ... \(meme.bottom)"
        cell.imageView?.image = meme.memedImage
        // to set the details text label
        cell.detailTextLabel?.text = "top: \(meme.top) ... bottom: \(meme.bottom)"
        return cell
    }
    // when I select the cell , it show me the details of the cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemesDetailViewController") as! MemesDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
}
