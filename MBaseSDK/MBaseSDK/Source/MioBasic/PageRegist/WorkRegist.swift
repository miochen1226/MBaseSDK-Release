

import UIKit

class WorkRegist: NSObject {
    func doRegistPageImplement(author:MBAuthor,implementPageDatas:[dataMapObj])
    {
        for implementPageData in implementPageDatas
        {
            let identiy = implementPageData["identiy"] as? String ?? ""
            let nibName = implementPageData["nibName"] as? String
            let type = implementPageData["type"] as? UIViewController.Type
            let api = implementPageData["api"] as? Bool ?? false
            
            PageFactory.sharedInstance.updatePageInfo(identiy: identiy, author: author, type: type, nibName: nibName,api:api)
        }
    }
}
