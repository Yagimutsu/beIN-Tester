//
//  AppDelegate.swift
//  bein Tester
//
//  Created by Yagiz Ugur on 26.06.2019.
//  Copyright © 2019 Yagimutsu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window?.rootViewController = ViewController()
        
       return true
    }

    


}

