//
//  UIDataProvider.swift
//  jourdenessSPA
//
//  Created by mio on 2019/4/15.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

public typealias dataMapObj = [String : Any]
public typealias funcGetDataMap = () -> dataMapObj

public protocol UIDataProviderProtocal:class{
    func getTableData()->dataMapObj
}

protocol UIDataProviderDataSourceProtocal:class{
    func getSourceDataMap(_ dataProvider:UIDataProvider)->dataMapObj
    func getSourceTableData(_ dataProvider:UIDataProvider)->dataMapObj
}

open class UIDataProvider:NSObject ,UIDataProviderProtocal {
    var observers:[BaseVC?] = []
    var dataSoueceDelegate:UIDataProviderDataSourceProtocal?
    
    var dataMapHandler:funcGetDataMap? = nil
    var tableDataMapHandler:funcGetDataMap? = nil
    
    public func setDataMapHandler(dataMapHandler:@escaping funcGetDataMap)
    {
        self.dataMapHandler = dataMapHandler
    }
    
    public func setTableDataMapHandler(tableDataMapHandler:@escaping funcGetDataMap)
    {
        self.tableDataMapHandler = tableDataMapHandler
    }
    
    public func addObserver(observer:BaseVC)
    {
        let exists = self.observers.contains { (grade) -> Bool in
            grade! == observer
        }
        
        if(!exists)
        {
            self.observers.append(observer)
        }
    }
    
    public func removeObserver(observer:BaseVC)
    {
        let index:Int = self.observers.firstIndex(of: observer) ?? -1
        if(index>=0)
        {
            self.observers.remove(at: index)
        }
    }
    
    open func notifyDataChange()
    {
        DispatchQueue.main.async() {
            for observer in self.observers
            {
                observer?.didDataUpdated()
            }
        }
    }
    
    //Data provide
    open func getTableData()->dataMapObj
    {
        if(self.tableDataMapHandler != nil)
        {
            return self.tableDataMapHandler!()
        }
        if(self.dataSoueceDelegate != nil)
        {
            return self.dataSoueceDelegate!.getSourceTableData(self)
        }
        return [:]
    }
    
    open func getDataMap()->dataMapObj
    {
        if(self.dataMapHandler != nil)
        {
            return self.dataMapHandler!()
        }
        if(self.dataSoueceDelegate != nil)
        {
            return self.dataSoueceDelegate!.getSourceDataMap(self)
        }
        return [:]
    }
}
