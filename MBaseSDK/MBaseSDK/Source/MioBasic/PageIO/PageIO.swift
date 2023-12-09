//
//  PageIO.swift
//  MBaseSDK
//
//  Created by mio on 2019/9/3.
//  Copyright © 2019 mio. All rights reserved.
//

import Foundation

open class PageDataTemplate: NSObject{
    open var name = ""
    open var dataInit: dataMapObj?
    open var data: dataMapObj?
}

@objc public protocol PageIoProtocol: AnyObject{
    //頁面主動提供的測試情境範本
    func getDataTemplates() -> [PageDataTemplate]
    
    //套用DataTemplate資料,由名稱
    func applyDataTemplate(name: String)
    
    //套用DataTemplate資料
    func applyDataTemplate(pageDataTemplate: PageDataTemplate)
    
    //套用DataTemplate資料後處理
    func didApplyDataTemplate()
}
