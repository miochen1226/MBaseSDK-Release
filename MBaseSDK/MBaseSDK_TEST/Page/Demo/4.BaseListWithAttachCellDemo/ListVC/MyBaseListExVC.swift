//
//  MyBaseListExVC.swift
//  MBaseTestBed
//
//  Created by mio on 2020/5/5.
//  Copyright © 2020 miochen. All rights reserved.
//

import UIKit
import MBaseSDK
class MyBaseListExVC: BaseListVC {
    
    let myBaseListExVC_Data = MyBaseListExVC_Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataProvider = myBaseListExVC_Data
        // Do any additional setup after loading the view.
    }

    override func getAttachVcByClassIdentity(attachedIdentity:String)->UIViewController.Type?
    {
        if(attachedIdentity == "AttachedVC")
        {
            return AttachedVC.self
        }
        else if(attachedIdentity == "BaseVCDemoVC")
        {
            return BaseVCDemoVC.self
        }
        else if(attachedIdentity == "UIDataProviderDemoVC")
        {
            return UIDataProviderDemoVC.self
        }
        else if(attachedIdentity == "BaseListDemoVC")
        {
            return BaseListDemoVC.self
        }
        else if(attachedIdentity == "BaseListWithAttachCellDemoVC")
        {
            return BaseListWithAttachCellDemoVC.self
        }
        
        return BaseVC.self
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let baseVC = getBaseVcForCell(indexPath: indexPath)
        let baseAutoHeightVC = baseVC as? BaseAutoHeightVC
        let height = baseAutoHeightVC?.getPerferHeight() ?? 500
        return height
    }
    
    func allowInsertSelf()->Bool
    {
        self.myBaseListExVC_Data.allowAddSelf = !self.myBaseListExVC_Data.allowAddSelf
        self.myBaseListExVC_Data.notifyDataChange()
        return  self.myBaseListExVC_Data.allowAddSelf
    }
}
