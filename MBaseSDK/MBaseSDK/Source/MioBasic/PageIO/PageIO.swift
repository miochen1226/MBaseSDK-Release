//
//  PageIO.swift
//  Jurassic
//
//  Created by mio on 2019/9/3.
//  Copyright © 2019 mio. All rights reserved.
//

import Foundation

open class PageDataTemplate:NSObject{
    open var name = ""
    open var data:dataMapObj?
}

public protocol PageIoProtocol:AnyObject{
    
    //頁面主動提供的測試情境範本
    //[[identity:"Test_1",data:dataMapObj],[identity:"Test_2",data:dataMapObj]]
    func getDataTemplates()->[PageDataTemplate]
    
    func applyDataTemplate(name: String)
    //套用頁面提供的測試資料範本
    //func applyInputTemplate(identity:String)
    
    //預設Input範本 -> 提供給用戶填充
    //func getDefaultInputTemplates()->dataMapObj
    
    //套用Input資料
    func applyDataTemplate(data:dataMapObj)
}
