//
//  MBDirectoryVC.swift
//  MBaseSDK
//
//  Created by mio on 2020/5/2.
//  Copyright © 2020 mio. All rights reserved.
//

import UIKit

public class MBDirectoryVC: BaseListVC {

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DemoPage"
        let bundle = Bundle.init(for: MBDirectoryVC.self)
        let nib = UINib(nibName: "MBDirectoryCell", bundle: bundle)
        self.tableView.register(nib, forCellReuseIdentifier: "MBDirectoryCell")
        
        let directoryDataProvider = MBDirectoryDataProvider()
        self.dataProvider = directoryDataProvider
        
        let developingIdentity = PageFactory.developingIdentity
        if developingIdentity != "" {
            PageTool.doPushPage(identity: PageFactory.developingIdentity, initData: [:], vc: self, dismissResult: nil,animated: false)
        }
    }
    
    override open func headerVcForSectoin(_ section: Int) -> BaseVC? {
        let dataMap = self.dataMapForSection(section: section)
        let nibName = dataMap["nibName"] as? String ?? ""
        
        if nibName != "" {
            let headerClass:BaseTableHeader.Type = headerVcClass(nibName) as! BaseTableHeader.Type
            let bundle = Bundle.init(for: MBDirectoryVC.self)
            let header = headerClass.init(nibName: nibName, bundle: bundle)
            header.dataMap = dataMap
            header.delegate = self
            header.view.tag = section
            headerMap[section] = header
        }
        return headerMap[section]
    }
    
    public override func cellNameMapForBase() -> [String] {
        return ["MBDirectoryCell"]
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let dataMapCell = self.dataMapForCell(indexPath: indexPath)
        
        let haveImplement = dataMapCell["haveImplement"] as? Bool ?? false
        if haveImplement == false {
            return
        }
        
        let identity = dataMapCell["identity"] as! String
        let bundle = Bundle.init(for: MBDirectoryVC.self)
        let demoPageViewerVC = MBDemoPageViewerVC.init(nibName: "MBDemoPageViewerVC", bundle: bundle)
        demoPageViewerVC.identity = identity
        self.navigationController?.pushViewController(demoPageViewerVC, animated: true)
    }
}
