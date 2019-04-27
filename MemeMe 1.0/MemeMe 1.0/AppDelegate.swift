//
//  AppDelegate.swift
//  MemeMe 1.0
//
//  Created by Asmahero on ٧ شعبان، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Asmahero. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //meme array
    var memes = [Meme]()
  
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

}

