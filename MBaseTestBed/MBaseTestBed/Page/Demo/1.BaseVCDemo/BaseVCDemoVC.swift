//
//  BaseTestVC.swift
//  MBaseTestBed
//
//  Created by mio on 2020/4/9.
//  Copyright © 2020 miochen. All rights reserved.
//

import UIKit
import MBaseSDK

class BaseVCDemoVC: BasePageVC {

    override class func getPageIdentity() -> String {
        return "1.BaseVC Demo"
    }
    
    override class func getPageNibName() -> String {
        return "BaseVCDemoVC"
    }
    
    override class func getAuthor() -> MBAuthor {
        return AuthorDef.Mio
    }
    
    override class func isDevloping() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func doInit(dataInit: dataMapObj) {
        self.dataMap = dataInit
        self.viewDidLayoutSubviews()
    }
    
    //Demo for push page in
    @IBAction func didPushClicked(_ sender:Any)
    {
        let pageDataTempdate = getPageDataTemplates()[1]
        let initData = pageDataTempdate.data ?? [:]
        PageTool.doPushPage(identity: "1.BaseVC Demo", initData: initData, vc: self, dismissResult: nil)
    }
    
    //Demo for present page
    @IBAction func didPresentClicked(_ sender:Any)
    {
        let pageDataTempdate = getPageDataTemplates()[1]
        let initData = pageDataTempdate.data ?? [:]
        PageTool.doPresentPage(identity: "1.BaseVC Demo", initData:initData, vc: self, dismissResult: nil)
    }
}

extension BaseVCDemoVC:BasePageProtocal
{
    @objc func getPageDataTemplates() -> [PageDataTemplate] {
        let pageDataTemplate1 = PageDataTemplate()
        pageDataTemplate1.name = "template_1"
        pageDataTemplate1.data = ["labelTitle":"BasePageVC",
        "ivImage":"https://cdn.carnews.com/thumb/1236x989/article/08f23f78-e682-11e9-a795-42010af00004/Dn8Lmhw6XCg8.jpg","btnPush":"Push","btnPresent":"Present","btnClose":"Close","btnBack":"Back"]
        
        let pageDataTemplate2 = PageDataTemplate()
        pageDataTemplate2.name = "template_2"
        pageDataTemplate2.data = ["labelTitle":"BasePageVC",
        "ivImage":"https://fate-15th.com/assets/img/pc/img_main.jpg","btnPush":"Push","btnPresent":"Present","btnClose":"Close","btnBack":"Back"]
        return [pageDataTemplate1,pageDataTemplate2]
    }
}
