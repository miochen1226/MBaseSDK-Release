//
//  BasePageVC.swift
//  MBaseTestBed
//
//  Created by mio on 2020/5/2.
//  Copyright © 2020 innoorz. All rights reserved.
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
    
    public static func registerPageFactory()
    {
        let pageFactory = PageFactory.sharedInstance
        let pageIdentity = getPageIdentity()
        if(self.isDevloping())
        {
            PageFactory.developingIdentity = getPageIdentity()
        }
        if(pageIdentity != "")
        {
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

extension BasePageVC: PageIoProtocol {
    open func getDataTemplates() -> [PageDataTemplate] {
        return (self as? BasePageProtocal)?.getPageDataTemplates?() ?? []
    }
    
    open func applyDataTemplate(name: String) {
        for dataTemplate in getDataTemplates()
        {
            if(dataTemplate.name == name && dataTemplate.data != nil)
            {
                super.doInit(dataInit: dataTemplate.data!)
                self.dataMap = dataTemplate.data!
            }
        }
    }
    
    open func applyDataTemplate(data: dataMapObj) {
        super.doInit(dataInit: data)
        self.dataMap = data
    }
}

