//
//  BaseListDemoVC.swift
//  MBaseTestBed
//
//  Created by mio on 2020/5/5.
//  Copyright © 2020 miochen. All rights reserved.
//

import UIKit
import MBaseSDK

class BaseListDemoVC: BasePageVC {

    @IBOutlet weak var viewList:UIView!
    
    override class func getPageIdentity() -> String {
        return "3.BaseList Demo"
    }
    
    override class func getPageNibName() -> String {
        return "BaseListDemoVC"
    }
    
    override class func getAuthor() -> MBAuthor {
        return AuthorDef.Mio
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.dataMap["labelList"] = "BaseListDemoVC"
        self.dataMap["btnTest"] = "Push me"
        self.dataMap["btnClean"] = "Clean all"
        
        AttachMyBaseListVC()
    }

    func AttachMyBaseListVC()
    {
        super.appendViewController(type: MyBaseListVC.self, nibName: "MyBaseListVC", controlId: "MyBaseListVC", to: self.viewList)
    }
    
    @IBAction func didTestClicked(_ sender:Any)
    {
        let myBaseListVC = super.getSubViewControlByID("MyBaseListVC") as? MyBaseListVC
        myBaseListVC?.insertItems()
    }
    
    @IBAction func didCleanClicked(_ sender:Any)
    {
        let myBaseListVC = super.getSubViewControlByID("MyBaseListVC") as? MyBaseListVC
        myBaseListVC?.cleanItems()
    }
}
