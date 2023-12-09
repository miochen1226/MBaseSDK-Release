//
//  BasePageVC.swift
//  MBaseSDK
//
//  Created by mio on 2020/5/2.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit


@objc public protocol BasePageProtocal {
    @objc optional func getPageDataTemplates() -> [PageDataTemplate]
}

@objc open class BasePageVC: BaseVC {
    open class func getPageIdentity() -> String {
        return ""
    }
    
    open class func getPageNibName() -> String {
        return ""
    }
    
    open class func getAuthor() -> MBAuthor {
        return MBAuthor(authorId: -1, name: "Unassigned")
    }
    
    open class func isDevloping() -> Bool {
        return false
    }
    
    public static func registerPageFactory() {
        let pageFactory = PageFactory.sharedInstance
        let pageIdentity = getPageIdentity()
        if self.isDevloping() {
            PageFactory.developingIdentity = getPageIdentity()
        }
        
        if pageIdentity != "" {
            pageFactory.addPage(pageIdentity)
            let pageInfo = pageFactory.getPageInfoByIdentity(identity: pageIdentity)
            let author = MBAuthorCenter.getAuthorById(authorId: getAuthor().authorId)
            pageInfo?.updatePageInfo(author: author, type: self, nibName: getPageNibName(), api: true)
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//資料範本處理
extension BasePageVC: PageIoProtocol {
    open func getDataTemplates() -> [PageDataTemplate] {
        return (self as? BasePageProtocal)?.getPageDataTemplates?() ?? []
    }
    
    open func applyDataTemplate(name: String) {
        for pageDataTemplate in getDataTemplates() {
            if pageDataTemplate.name == name {
                self.applyDataTemplate(pageDataTemplate: pageDataTemplate)
            }
        }
    }
    
    open func applyDataTemplate(pageDataTemplate: PageDataTemplate) {
        if pageDataTemplate.dataInit != nil {
            super.doInit(dataInit: pageDataTemplate.dataInit!)
            self.didApplyDataTemplate()
        }
        
        if pageDataTemplate.data != nil {
            self.dataMap = pageDataTemplate.data!
        }
        self.didApplyDataTemplate()
    }
    
    open func didApplyDataTemplate() {
        
    }
}

