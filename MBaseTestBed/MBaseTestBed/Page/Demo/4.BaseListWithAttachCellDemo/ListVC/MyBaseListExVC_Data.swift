//
//  MyBaseListExVC_Data.swift
//  MBaseTestBed
//
//  Created by mio on 2020/5/5.
//  Copyright © 2020 miochen. All rights reserved.
//

import UIKit
import MBaseSDK

class MyBaseListExVC_Data: UIDataProvider {
    
    var allowAddSelf:Bool = false
    
    override func getTableData() -> [String : Any] {
        
        var secArray:[dataMapObj] = []
        var sec_1_node:dataMapObj = ["secName":""]
        sec_1_node["dataMap"] = []
        
        var cellArray:[dataMapObj] = []
       
        //Add AttachedVC
        cellArray.append(createItemData(attachedIdentity: "AttachedVC", attachedNibName: "AttachedVC",data: ["labelTitle":"AttachedVC"]))
        
        //Add BaseVCDemoVC
        let dataForBaseVCDemoVC = ["labelTitle":"BasePageVC",
        "ivImage":"https://cdn.carnews.com/thumb/1236x989/article/08f23f78-e682-11e9-a795-42010af00004/Dn8Lmhw6XCg8.jpg","btnPush":"Push","btnPresent":"Present","btnClose":"Close","btnBack":"Back"]
        cellArray.append(createItemData(attachedIdentity: "BaseVCDemoVC", attachedNibName: "BaseVCDemoVC",data: dataForBaseVCDemoVC))
        
        //Add UIDataProviderDemoVC
        cellArray.append(createItemData(attachedIdentity: "UIDataProviderDemoVC", attachedNibName: "UIDataProviderDemoVC",data: nil))
        cellArray.append(createItemData(attachedIdentity: "BaseListDemoVC", attachedNibName: "BaseListDemoVC",data: nil))
        
        if(allowAddSelf)
        {
            //Add BaseListWithAttachCellDemoVC
            cellArray.append(createItemData(attachedIdentity: "BaseListWithAttachCellDemoVC", attachedNibName: "BaseListWithAttachCellDemoVC",data: nil))
        }
        
        
        sec_1_node["list"] = cellArray
        secArray.append(sec_1_node)
        
        var tableData:dataMapObj = [:]
        tableData["list"] = secArray
        return tableData
    }
    
    func createItemData(attachedIdentity:String,attachedNibName:String,data:dataMapObj?)->dataMapObj
    {
        var itemData = dataMapObj()
        itemData["nibName"] = ""
        var attachVc = dataMapObj()
        attachVc["attachedIdentity"] = attachedIdentity
        attachVc["attachedNibName"] = attachedNibName
        if(data != nil)
        {
            attachVc["data"] = data
        }
        itemData["attachedVC"] = attachVc
        return itemData
    }
}
