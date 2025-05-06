//
//  UITableDataProvider.swift
//  Jurassic
//
//  Created by mio on 2019/11/20.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

public protocol UITableDataProviderDelegate: AnyObject {
    func emptyCellData()->dataMapObj
    func itemObjToCellData(data: Any?, nibName: String) -> dataMapObj
}

open class UITableDataProvider: UIDataProvider {
    open weak var delegate:UITableDataProviderDelegate?
    
    open class ItemPack {
        open var itemId:String = ""
        open var data:Any?
        open var nibName:String = ""
        public init(itemId:String, data:Any?, nibName: String) {
            self.itemId = itemId
            self.data = data
            self.nibName = nibName
        }
        
        open func getData() -> Any? {
            return data
        }
        
        open func updateData(itemId: String?, data: Any?, nibName: String?) {
            if(itemId != nil) {
                self.itemId = itemId!
                self.needRefresh = true
            }
            
            if(data != nil) {
                self.data = data!
                self.needRefresh = true
            }
            
            if(nibName != nil) {
                self.nibName = nibName!
                self.needRefresh = true
            }
        }
        
        public var needRefresh:Bool = false
    }
    
    public init(delegate: UITableDataProviderDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    open var items: [ItemPack] = []
    open var showEmpty: Bool = false {
        didSet{
            self.notifyDataChange()
        }
    }

    open func deleteAllItems() {
        self.items = []
        self.notifyDataChange()
    }

    open func itemsCount() -> Int64 {
        return Int64(self.items.count)
    }
    
    open func insertItem(itemId: String, data: Any, nibName: String) {
        let itemPack = ItemPack.init(itemId: itemId, data: data, nibName: nibName)
        items.append(itemPack)
    }
    
    open func deleteItem(itemId: String) {
        var index = 0
        for itemPack in items {
            if(itemPack.itemId == itemId) {
                items.remove(at: index)
                self.notifyDataChange()
                return
            }
            index = index + 1
        }
    }
    
    open func getItems() -> [dataMapObj] {
        var array:[dataMapObj] = []
        for itemPack in items {
            array.append(dataToDataMapObj(data: itemPack.data,nibName:itemPack.nibName))
        }
        return array
    }
    
    open func dataToDataMapObj(data: Any?, nibName: String) -> dataMapObj {
        return delegate?.itemObjToCellData(data: data,nibName:nibName) ?? dataMapObj()
    }
    
    open override func getTableData() -> [String : Any] {
        var secArray:[dataMapObj] = []
        var sec_1_node:dataMapObj = ["secName":""]
        sec_1_node["dataMap"] = []
        
        var cellArray:[dataMapObj] = []
        for item in self.getItems() {
            cellArray.append(item)
        }
        
        if(self.showEmpty && self.getItems().count == 0) {
            let emptyCellData = self.delegate?.emptyCellData()
            if(emptyCellData != nil) {
                cellArray.append(emptyCellData!)
            }
        }
        
        sec_1_node["list"] = cellArray
        secArray.append(sec_1_node)
        
        var tableData:dataMapObj = [:]
        tableData["list"] = secArray
        return tableData
    }
}
