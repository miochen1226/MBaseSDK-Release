//
//  UIDataProviderDemoVC.swift
//  MBaseTestBed
//
//  Created by mio on 2020/4/9.
//  Copyright © 2020 miochen. All rights reserved.
//

import UIKit
import MBaseSDK

class MyDataProvider: UIDataProvider {
    var labelText = "UIDataProviderDemoVC"
    var imageUrl = "https://cdn.carnews.com/thumb/1236x989/article/08f23f78-e682-11e9-a795-42010af00004/Dn8Lmhw6XCg8.jpg"
    override func getDataMap() -> dataMapObj {
        return ["labelTitle":labelText,
                "btnTest":"Push me",
                "ivImage":imageUrl]
    }
}

class UIDataProviderDemoVC: BasePageVC {
    override class func getPageIdentity() -> String {
        return "2.UIDataProvider Demo"
    }
    
    override class func getPageNibName() -> String {
        return "UIDataProviderDemoVC"
    }
    
    override class func getAuthor() -> MBAuthor {
        return AuthorDef.Mio
    }
    
    let myDataProvider = MyDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataProvider = myDataProvider
    }
    
    @IBAction func didTestClicked(_ sender: Any) {
        myDataProvider.labelText = "Pressed"
        myDataProvider.imageUrl = "https://fate-15th.com/assets/img/pc/img_main.jpg"
        myDataProvider.notifyDataChange()
    }
}
