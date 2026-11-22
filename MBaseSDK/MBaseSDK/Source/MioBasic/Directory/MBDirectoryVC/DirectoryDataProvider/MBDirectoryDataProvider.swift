//
//  MBDirectoryDataProvider.swift
//  MBaseTestBed
//
//  Created by mio on 2020/5/2.
//  Copyright © 2020 innoorz. All rights reserved.
//

import UIKit

class MBDirectoryDataProvider: UIDataProvider {
    override func getDataMap() -> dataMapObj {
        var data = dataMapObj.init()
        data["labelTitle"] = "Contents"
        return data
    }
    
    func getSecNode(author:MBAuthor)->dataMapObj?
    {
        let pages = PageFactory.sharedInstance.getPageInfosByAuthor(author: author)
        
        let totalCount = pages.count
        var implementCount = 0
        
        var sec:[dataMapObj] = []
        
        if(pages.count == 0)
        {
            return nil
        }
        
        for pageInfo in pages
        {
            var dataMap:dataMapObj = [:]
            dataMap["identity"] = pageInfo.getIdentiy()
            dataMap["implementClass"] = pageInfo.getImplementClassName()
            dataMap["haveImplement"] = pageInfo.haveImplement()
            dataMap["haveApiImplement"] = pageInfo.haveApiImplement()
            dataMap["labelAuthor"] = pageInfo.getAuthorName()
            
            
            dataMap["nibName"] = "MBDirectoryCell"
            if(pageInfo.haveImplement())
            {
                implementCount = implementCount + 1
            }
            sec.append(dataMap)
        }
        
        var node:[String:Any] = ["secName":"","list":sec]
        //Cell Header
        let strImpCount = String(implementCount)
        let strTotalCount = String(totalCount)
        let status = strImpCount + " / " + strTotalCount
        
        node["dataMap"] = ["nibName":"MBDemoStageCellHeader","author":author.getName(),"status":status]
        
        return node
    }
    
    override func getTableData() -> [String : Any] {
        
        var tableData:[String:Any] = [:]
        
        var list:[dataMapObj] = []
        
        
        for author in MBAuthorCenter.getAuthors()
        {
            let secNode = getSecNode(author: author)
            if(secNode != nil)
            {
                list.append(secNode!)
            }
        }
        
        tableData["list"] = list
        return tableData
    }
}
