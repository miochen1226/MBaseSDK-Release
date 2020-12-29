//
//  BaseDOListVC.swift
//  MBaseSDK_TEST
//
//  Created by mio on 2020/12/25.
//

import UIKit
import MBaseSDK

class ChatMessageDO:NSObject{
    var itemID:String = ""
    var message:String = ""
    var name:String = ""
    var date:Date? = nil
    
    func getFullDateTimeStr(date:Date)->String
    {
        let locale = "zh-TW"
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale.init(identifier: locale)
        dateFormatter.dateStyle = .short
        
        if(locale == "zh-TW")
        {
            dateFormatter.dateFormat = "HH:mm:ss"
        }
        else
        {
            dateFormatter.dateFormat = "YYYY/MM/dd HH:mm"
        }
        let dateStrig = dateFormatter.string(from:date)
        return dateStrig
    }
    
    func getTimeStr()->String
    {
        if(self.date != nil)
        {
            return self.getFullDateTimeStr(date: self.date!)
        }
        else
        {
            return ""
        }
    }
}

extension BaseDOListVC:UITableDataProviderDelegate
{
    func emptyCellData() -> dataMapObj {
        var itemDataEmpty = dataMapObj()
        itemDataEmpty["nibName"] = "AuctionEmptyWithCheckScheduleCell"
        itemDataEmpty["emptyInfo"] = "Bidding_Page_No_Data"
        itemDataEmpty["btnCheckSchedule"] = "registed_auction_item_check_schedule"
        return itemDataEmpty
    }
    
    func itemObjToCellData(data:Any?,nibName:String)->dataMapObj
    {
        var dataForCell = dataMapObj()
        let chatMessageDO:ChatMessageDO? = data as? ChatMessageDO ?? nil
        
        dataForCell["itemID"] = chatMessageDO?.itemID ?? ""
        dataForCell["time"] = chatMessageDO?.getTimeStr()
        dataForCell["message"] = chatMessageDO?.message
        dataForCell["name"] = chatMessageDO?.name
        dataForCell["nibName"] = nibName
        return dataForCell
    }
}

class BaseDOListVC: BaseListVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataProvider = UITableDataProvider(delegate: self)
        // Do any additional setup after loading the view.
        insertDatas()
        
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(BaseDOListVC.TEST), userInfo: nil, repeats: true)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BaseTableCell? = self.getCellByIdentify(identifier: cellClassIdentifyforIndex(indexPath),indexPath: indexPath)
        cell?.dataMap = dataMapForCell(indexPath: indexPath)
        
        let baseVC = self.getBaseVcForCell(indexPath:indexPath)
        if(baseVC != nil)
        {
            var viewBase:UIView? = nil
            if #available(iOS 14, *) {
                viewBase = cell?.contentView
            } else {
                viewBase = cell
            }
            
            if(viewBase != nil)
            {
                baseVC?.view.removeFromSuperview()
                viewBase!.addSubview(baseVC!.view)
                baseVC!.view.frame = CGRect.init(x: 0, y: 0, width: viewBase!.frame.size.width, height: viewBase!.frame.size.height)
            }
        }
        
        
        cell?.layoutIfNeeded()
        return cell!
    }

    func insertDatas()
    {
        for i in 1...20000
        {
            let data = ChatMessageDO()
            data.itemID = String(i)
            data.date = Date()
            data.message = "0"
            data.name = "item_" + String(i)
            self.tableDataProvider?.insertItem(itemId: "0", data: data, nibName: "DOTableViewCell")
        }
        self.tableDataProvider?.notifyDataChange()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            //cell.alpha = 0
        
        let itemPack = self.tableDataProvider?.items[indexPath.row]
        if(itemPack?.needRefresh == true)
        {
            itemPack?.needRefresh = false
            cell.backgroundColor = .yellow
        }
        UIView.animate(withDuration: 0.4) {
            //cell.alpha = 1
            cell.backgroundColor = .white
        }
    }
    
    var timer: Timer?
    
    @objc func TEST()
    {
        let number = Int.random(in: 1...4)
        
        for _ in 0...number
        {
            let index = Int.random(in: 1...7)
            let itemPack = self.tableDataProvider?.items[index]
            let chatMessageDO = itemPack?.getData() as? ChatMessageDO
            
            let value = Int.random(in: 1...100)
            chatMessageDO?.message = String(value)
            itemPack?.needRefresh = true
        }
        
        refreshItems()
    }
    
    func refreshItems()
    {
        var indexArray:[IndexPath] = []
        var index = 0
        for item in self.tableDataProvider?.items ?? []
        {
            if(item.needRefresh == true)
            {
                let indexPath = IndexPath.init(row: index, section: 0)
                indexArray.append(indexPath)
            }
            index+=1
        }
        
        loadTableDataViaDataProvider()
        tableView.beginUpdates()
        tableView.reloadRows(at: indexArray, with: UITableView.RowAnimation.automatic)
        tableView.endUpdates()
    }
}
