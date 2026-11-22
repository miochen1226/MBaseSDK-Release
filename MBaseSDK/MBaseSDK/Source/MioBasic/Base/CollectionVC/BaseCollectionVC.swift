//
//  BaseCollectionVC.swift
//  jourdenessSPA
//
//  Created by mio on 2019/3/31.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit
/*
protocol BaseCollectionDelegate {
    func cellNameMapForBase() -> [String]
    func cellClassIdentifyforIndex(_ indexPath:IndexPath)->String
}
*/

open class BaseCollectionVC:
BaseVC,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BaseCollectionCellDelegate{
    
    open func didBaseCollectionCellButtonClicked(data:dataMapObj)
    {
        
    }
    
    open func cellClassIdentifyforIndex(_ indexPath: IndexPath) -> String {
        let dataCell = self.dataMapForCell(indexPath: indexPath)
        let nibName = dataCell["nibName"] as? String ?? "BaseCollectionCell"
        return nibName
    }
    
    open func cellNameMapForBase() -> [String] {
        return ["BaseCollectionCell"]
    }
    
    var tableData:[String:Any] = [:]
    
    open func getItemCount(section:Int)->Int
    {
        let sections = self.tableData["list"] as! [[String:Any]]
        let listItems = sections[section]["list"] as! [[String:Any]]
        return listItems.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.getItemCount(section: section)
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(self.tableData["list"] == nil)
        {
            return 0
        }
        let sections = self.tableData["list"] as! [[String:Any]]
        return sections.count
    }
    
    open func dataMapForCell(indexPath: IndexPath)->[String:Any]
    {
        let sections = self.tableData["list"] as! [[String:Any]]
        let listItems = sections[indexPath.section]["list"] as! [[String:Any]]
        return listItems[indexPath.row]
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.getCellByIdentify(identifier: cellClassIdentifyforIndex(indexPath),indexPath: indexPath) as! BaseCollectionCell
        cell.baseDelegate = self
        cell.dataMap = self.dataMapForCell(indexPath: indexPath)
        cell.layoutSubviews()
        cell.layoutIfNeeded()
        return cell
    }
    
    open func getCellByIdentify(identifier:String,indexPath:IndexPath) -> Any {
        var cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        if (cell == nil)
        {
            cell = (Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first) as? UICollectionViewCell
        }
        
        if( cell == nil)
        {
            cell = (Bundle.main.loadNibNamed("BaseCollectionCell", owner: self, options: nil)?.first) as? UICollectionViewCell
        }
        
        return cell as Any
    }
    
    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    @IBOutlet public weak var collectionView:UICollectionView!
    var arrayItems:NSMutableArray = NSMutableArray()
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadTableDataViaDataProvider()
        
        let cellClassMap = cellNameMapForBase()
        for nibName in cellClassMap
        {
            self.collectionView?.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
        }
        
        self.collectionView.allowsMultipleSelection = true
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    open override func didDataUpdated() {
        DispatchQueue.main.async() {
            super.didDataUpdated()
            self.loadTableDataViaDataProvider()
            self.collectionView?.reloadData()
            self.collectionView?.layoutIfNeeded()
        }
    }
    
    open func loadTableDataViaDataProvider()
    {
        if(self.dataProvider == nil)
        {
            return
        }
        self.tableData = self.dataProvider?.getTableData() ?? [:]//?? FakeDataProvider().getTableData()
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
    
    open override func loadDataViaDataProvider()
    {
        super.loadDataViaDataProvider()
        self.loadTableDataViaDataProvider()
    }
}
