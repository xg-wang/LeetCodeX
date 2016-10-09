//
//  LCXClient.swift
//  LeetCodeX
//
//  Created by Xingan Wang on 10/9/16.
//  Copyright © 2016 Xingan Wang. All rights reserved.
//

import UIKit
import DrawerController

class LCXClient: NSObject {
    static let sharedInstance = LCXClient()
    
    var drawerController: DrawerController?
    var centerVC: HomeViewController?
    var centerNC: LCXNavigationController?
    
    var topNavigationController: UINavigationController {
        return LCXClient.getTopNavigationController(currentNavigationController: LCXClient.sharedInstance.centerNC!)
    }
    
    private class func getTopNavigationController(currentNavigationController:UINavigationController) -> UINavigationController {
        if let topNav = currentNavigationController.visibleViewController?.navigationController{
            if topNav != currentNavigationController {
                return getTopNavigationController(currentNavigationController: topNav)
            }
        }
        return currentNavigationController
    }
}
