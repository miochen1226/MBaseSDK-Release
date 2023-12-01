//
//  PageTool.swift
//  MBaseSDK
//
//  Created by mio on 2019/10/4.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

public typealias ptDismissResult = ((_ outData: dataMapObj?) -> Void)?
open class PageTool: NSObject {
    
    public class func doCreatePage(identity: String, initData: dataMapObj) -> UIViewController? {
        let pageInfo = PageFactory.sharedInstance.getPageInfoByIdentity(identity: identity)
        if pageInfo != nil {
            let vcNext = createVcFromPageInfo(pageInfo: pageInfo!,initData: initData,dismissResult: nil)
            return vcNext
        }
        return nil
    }
    
    public class func doPushPage(identity: String, initData: dataMapObj, vc: UIViewController, dismissResult: ptDismissResult, animated: Bool = true) {
        let pageInfo = PageFactory.sharedInstance.getPageInfoByIdentity(identity: identity)
        if pageInfo != nil {
            let vcNext = createVcFromPageInfo(pageInfo: pageInfo!,initData: initData,dismissResult: dismissResult)
            if vcNext != nil {
                vc.navigationController?.pushViewController(vcNext!, animated: animated)
            }
        }
    }
    
    public class func doPresentPage(identity: String, initData: dataMapObj, vc: UIViewController, animated: Bool = true, dismissResult: ptDismissResult) {
        let pageInfo = PageFactory.sharedInstance.getPageInfoByIdentity(identity: identity)
        if pageInfo != nil {
            let vcNext = createVcFromPageInfo(pageInfo: pageInfo!,initData:initData,dismissResult: dismissResult)
            if vcNext != nil {
                let naviVC = UINavigationController.init(rootViewController: vcNext!)
                naviVC.navigationBar.isHidden = true
                naviVC.modalPresentationStyle = .fullScreen
                vc.present(naviVC, animated: animated, completion: nil)
            }
        }
    }
    
    public class func doPresentFullPage(identity: String, initData: dataMapObj, vc: UIViewController, dismissResult: ptDismissResult) {
        let pageInfo = PageFactory.sharedInstance.getPageInfoByIdentity(identity: identity)
        if pageInfo != nil {
            let vcNext = createVcFromPageInfo(pageInfo: pageInfo!,initData:initData,dismissResult: dismissResult)
            if vcNext != nil {
                vc.present(vcNext!, animated: true, completion: nil)
            }
        }
    }
    
    public class func createVcFromPageInfo(pageInfo: PageInfo, initData: dataMapObj, dismissResult: ptDismissResult) -> UIViewController? {
        let nibName = pageInfo.getNibName()
        let implementType = pageInfo.getImplementType() ?? nil
        if implementType != nil {
            let vcEnter = implementType!.init(nibName: nibName, bundle: nil)
            let baseVC = vcEnter as? BaseVC
            if baseVC != nil {
                baseVC?.doInit(dataInit: initData)
                baseVC?.ptDismissHandler = dismissResult
            }
            return vcEnter
        }
        return nil
    }
}
