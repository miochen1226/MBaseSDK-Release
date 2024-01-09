//
//  UITableDataProviderDemoVC.swift
//  MBaseSDK_TEST
//
//  Created by mio on 2020/12/15.
//

import UIKit
import MBaseSDK

class UITableDataProviderDemoVC: BasePageVC {
    @IBOutlet weak var viewList:UIView!
    override class func getPageIdentity() -> String {
        return "5.UITableDataProviderDemoVC"
    }
    
    override class func getPageNibName() -> String {
        return "UITableDataProviderDemoVC"
    }
    
    override class func getAuthor() -> MBAuthor {
        return AuthorDef.Mio
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataMap["btnLoad"] = "LOAD"
        super.appendViewController(type: BaseAuctionListVC.self, nibName: "BaseAuctionListVC", controlId: "BaseAuctionListVC", to: self.viewList)
        // Do any additional setup after loading the view.
    }

    @IBAction func didLoadeFakeBtnClicked(_ sender: Any) {
        let baseAuctionListVC = super.getSubViewControlByID("BaseAuctionListVC") as? BaseAuctionListVC
        baseAuctionListVC?.doFetchListData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
