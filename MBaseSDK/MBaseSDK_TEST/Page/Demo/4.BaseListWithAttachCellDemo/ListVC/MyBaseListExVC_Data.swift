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
    var allowAddSelf: Bool = false
    override func getTableData() -> [String : Any] {
        
        var secArray:[dataMapObj] = []
        var sec_1_node:dataMapObj = ["secName":""]
        sec_1_node["dataMap"] = []
        
        var cellArray:[dataMapObj] = []
       
        //Add AttachedVC
        cellArray.append(createItemData(attachedIdentity: "Att_1_VC", attachedNibName: "Att_1_VC",data: ["labelTitle":"Field1","btnOption":"Option"]))
        
        cellArray.append(createItemData(attachedIdentity: "Att_2_VC", attachedNibName: "Att_2_VC",data: ["labelTitle":"Field2","btnSend":"Send"]))
        
        if allowAddSelf {
            //Add BaseListWithAttachCellDemoVC
            cellArray.append(createItemData(attachedIdentity: "BaseListWithAttachCellDemoVC", attachedNibName: "BaseListWithAttachCellDemoVC",data: nil))
        }
        
        sec_1_node["list"] = cellArray
        secArray.append(sec_1_node)
        
        var tableData:dataMapObj = [:]
        tableData["list"] = secArray
        return tableData
    }
    
    func createItemData(attachedIdentity: String, attachedNibName: String, data: dataMapObj?) -> dataMapObj {
        var itemData = dataMapObj()
        itemData["nibName"] = ""
        var attachVc = dataMapObj()
        attachVc["attachedIdentity"] = attachedIdentity
        attachVc["attachedNibName"] = attachedNibName
        if data != nil {
            attachVc["data"] = data
        }
        itemData["attachedVC"] = attachVc
        return itemData
    }
}
