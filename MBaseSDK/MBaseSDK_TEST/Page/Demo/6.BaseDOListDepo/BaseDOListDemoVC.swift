//
//  BaseDOListDemoVC.swift
//  MBaseSDK_TEST
//
//  Created by mio on 2020/12/25.
//

import UIKit
import MBaseSDK

class BaseDOListDemoVC: BasePageVC {

    @IBOutlet weak var viewList:UIView!
    override class func getPageIdentity() -> String {
        return "6.BaseDOListDepo"
    }
    
    override class func getPageNibName() -> String {
        return "BaseDOListDemoVC"
    }
    
    override class func getAuthor() -> MBAuthor {
        return AuthorDef.Mio
    }
    
    override class func isDevloping() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataMap["btnTEST"] = "測試"
        super.appendViewController(type: BaseDOListVC.self, nibName: "BaseDOListVC", controlId: "BaseDOListVC", to: self.viewList)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTestClicked(_ sender: Any) {
        let baseDOListVC = super.getSubViewControlByID("BaseDOListVC") as? BaseDOListVC
        baseDOListVC?.TEST()
    }
}
