//
//  AppDelegate.swift
//  MBaseTestBed
//
//  Created by mio on 2020/4/9.
//  Copyright © 2020 innoorz. All rights reserved.
//

import UIKit
import MBaseSDK
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        scanAndBuildPages()
        enterDemoStage()
        
        // Override point for customization after application launch.
        return true
    }
    
    func scanAndBuildPages()
    {
        //Add unassign page
        //PageFactory.sharedInstance.addPage("TEST PAGE")
        
        //Add another Author
        //MBAuthorCenter.insertAuthor(author: AuthorDef.John)
        
        MBAuthorCenter.insertAuthor(author: AuthorDef.Mio)
        MBUtlity.prepareDemoPage()
    }

    func enterDemoStage()
    {
        /*
        if(PageFactory.developingIdentity != "")
        {
            let naviVC = UINavigationController.init()
            naviVC.navigationBar.isHidden = true
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = naviVC
            self.window?.makeKeyAndVisible()
        }
        else*/
        //{
            let pageVC = MBUtlity.createDemoPage()
            let naviVC = UINavigationController.init(rootViewController: pageVC)
            naviVC.navigationBar.isHidden = true
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = naviVC
            self.window?.makeKeyAndVisible()
        //}
        
    }
}

