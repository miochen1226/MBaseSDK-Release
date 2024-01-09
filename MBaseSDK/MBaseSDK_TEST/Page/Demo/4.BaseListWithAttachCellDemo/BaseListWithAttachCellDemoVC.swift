//
//  BaseListWithAttachCellDemoVC.swift
//  MBaseTestBed
//
//  Created by mio on 2020/5/5.
//  Copyright © 2020 miochen. All rights reserved.
//

import UIKit
import MBaseSDK

class BaseListWithAttachCellDemoVC: BasePageVC {
    @IBOutlet weak var viewList: UIView!
    override class func getPageIdentity() -> String {
        return "4.BaseList With Attach Cell Demo"
    }
    
    override class func getPageNibName() -> String {
        return "BaseListWithAttachCellDemoVC"
    }
    
    override class func getAuthor() -> MBAuthor {
        return AuthorDef.Mio
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataMap["btnTest"] = "Add Self"
        AttachMyBaseListVC()
    }
    
    func AttachMyBaseListVC() {
        super.appendViewController(type: MyBaseListExVC.self, nibName: "MyBaseListExVC", controlId: "MyBaseListExVC", to: self.viewList)
    }

    @IBAction func didTestClicked(_ sender: Any) {
        let myBaseListExVC = super.getSubViewControlByID("MyBaseListExVC") as? MyBaseListExVC
        let result = myBaseListExVC?.allowInsertSelf() ?? false
        if result == true {
            self.dataMap["btnTest"] = "Remove Self"
            self.viewDidLayoutSubviews()
        }
        else {
            self.dataMap["btnTest"] = "Add Self"
            self.viewDidLayoutSubviews()
        }
    }
}
