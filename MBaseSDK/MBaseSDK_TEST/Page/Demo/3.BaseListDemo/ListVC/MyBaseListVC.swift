//
//  MyBaseListVC.swift
//  MBaseTestBed
//
//  Created by mio on 2020/5/5.
//  Copyright © 2020 miochen. All rights reserved.
//

import UIKit
import MBaseSDK
class MyBaseListVC: BaseListVC {
    
    let myBaseListVC_Data = MyBaseListVC_Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataProvider = myBaseListVC_Data
        // Do any additional setup after loading the view.
    }

    override func cellNameMapForBase() -> [String] {
        return ["MyBaseListCell","EmptyCell"]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellData = super.dataMapForCell(indexPath: indexPath)
        
        let cellNib = cellData["nibName"] as? String ?? ""
        if(cellNib == "EmptyCell")
        {
            return self.view.frame.height
        }
        return 100
    }
    
    func insertItems()
    {
        for i in 10...30 {
            let itemId = String(i)
            let title = String(i) + "." + "Title"
            let descript =  "descript-" + String(i)
            let imageUrl = "https://www.fate-sn.com/assets_hf3/img/special/countdown/HF3-countdown100_"+String(i)+".jpg"
            myBaseListVC_Data.addItem(itemId: itemId, title: title, descript: descript, imageUrl: imageUrl)
            
        }
        myBaseListVC_Data.notifyDataChange()
    }
    
    func cleanItems()
    {
        myBaseListVC_Data.cleanItems()
    }
}
