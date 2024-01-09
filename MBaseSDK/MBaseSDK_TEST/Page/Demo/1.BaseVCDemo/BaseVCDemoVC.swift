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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func doInit(dataInit: dataMapObj) {
        self.dataMap = dataInit
        self.viewDidLayoutSubviews()
    }
    
    //Demo for push page in
    @IBAction func didPushClicked(_ sender: Any) {
        let pageDataTempdate = getPageDataTemplates()[1]
        let initData = pageDataTempdate.data ?? [:]
        PageTool.doPushPage(identity: "1.BaseVC Demo", initData: initData, vc: self, dismissResult: nil)
    }
    
    //Demo for present page
    @IBAction func didPresentClicked(_ sender: Any) {
        let pageDataTempdate = getPageDataTemplates()[1]
        let initData = pageDataTempdate.data ?? [:]
        PageTool.doPresentPage(identity: "1.BaseVC Demo", initData:initData, vc: self, dismissResult: nil)
    }
}

extension BaseVCDemoVC: BasePageProtocal {
    @objc func getPageDataTemplates() -> [PageDataTemplate] {
        let pageDataTemplate1 = PageDataTemplate()
        pageDataTemplate1.name = "template_1"
        pageDataTemplate1.data = ["labelTitle":"BasePage & PageTool",
                                  "ivImage":"https://upload.wikimedia.org/wikipedia/zh/e/e1/%E7%A6%8F%E5%88%A9%E7%86%8A.png",
                                  "btnPush": "Push",
                                  "btnPresent": "Present",
                                  "btnClose": "Close",
                                  "btnBack": "Back"]
        
        let pageDataTemplate2 = PageDataTemplate()
        pageDataTemplate2.name = "template_2"
        pageDataTemplate2.data = ["labelTitle": "BasePage & PageTool",
                                  "ivImage": "https://fate-15th.com/assets/img/pc/img_main.jpg",
                                  "btnPush": "推入",
                                  "btnPresent": "跳出",
                                  "btnClose": "關閉",
                                  "btnBack": "返回"]
        return [pageDataTemplate1,pageDataTemplate2]
    }
}
