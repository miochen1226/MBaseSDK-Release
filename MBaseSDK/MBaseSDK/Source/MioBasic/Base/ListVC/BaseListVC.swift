//
//  BaseListVC.swift
//  jourdenessSPA
//
//  Created by mio on 2019/3/21.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit


open class BaseListVC: BaseVC,UITableViewDelegate,UITableViewDataSource,BaseTableHeaderDelegate,BaseTableCellDelegate{
    
    open func didBaseTableCellButtonClicked(data: dataMapObj) {
        
    }
    
    open func didHeaderButtonClickedWithData(data: [String : Any]) {
        
    }
    
    open func didHeaderButtonClicked(tag: Int,section:Int) {
        
    }
    
    var alreadyInitial:Bool = false
    var enablePullToUpdate:Bool = false
    var refreshControl:UIRefreshControl?
    var baseDataPageInfo:BaseDataPageInfo = BaseDataPageInfo()
    @objc func refreshData()
    {
        
    }
    
    func didDiscountClicked(data: [String : Any])
    {
        
    }
    
    override func loadDataViaDataProvider()
    {
        super.loadDataViaDataProvider()
        
        if(self.dataProvider != nil)
        {
            self.loadTableDataViaDataProvider()
        }
        self.reloadTableView()
    }
    
    open override func didDataUpdated() {
        super.didDataUpdated()
    }
    
    func reloadTableData()
    {
        if(self.dataProvider != nil)
        {
            self.loadTableDataViaDataProvider()
        }
        self.reloadTableView()
    }
    
    open func didHeaderClicked(tag: Int) {
        
    }
    
    func reloadTableView()
    {
        if(tableView == nil)
        {
            return
        }
        let selectredRows = tableView.indexPathsForSelectedRows
        self.tableView.reloadData()
        selectredRows?.forEach({ (selectedRow) in
            self.tableView.selectRow(at: selectedRow, animated: false, scrollPosition: .none)
        })
    }
    
    @IBOutlet public weak var tableView:UITableView!
    
    var headerMap:[Int:BaseTableHeader] = [:]
    var customizeCellMap:[String:BaseVC] = [:]
    
    var tableData:[String:Any] = [:]
    var sepHeight = 10
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header:BaseVC? = self.headerVcForSectoin(section)
        return header?.view
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return -1
    }
    
    open func headerVcClass(_ className:String)->AnyClass
    {
        return BaseTableHeader.self
    }
    
    func headerVcForSectoin(_ section:Int)->BaseVC?
    {
        let dataMap = self.dataMapForSection(section: section)
        let nibName = dataMap["nibName"] as? String ?? ""
        
        if(nibName != "")
        {
            let headerClass:BaseTableHeader.Type = headerVcClass(nibName) as! BaseTableHeader.Type
            let header = headerClass.init(nibName: nibName, bundle: nil)
            header.dataMap = dataMap
            header.delegate = self
            header.view.tag = section
            headerMap[section] = header
        }
        return headerMap[section]
    }
    
    open func cellClassIdentifyforIndex(_ indexPath: IndexPath) -> String {
        let dataCell = self.dataMapForCell(indexPath: indexPath)
        let nibName = dataCell["nibName"] as? String ?? ""
        return nibName
    }
    
    open func cellNameMapForBase() -> [String] {
        return ["BaseTableCell"]
    }
    
    var cellTypeMap:[String:AnyClass] = [:]
    
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        //Data Provider
        
        self.loadTableDataViaDataProvider()
        self.loadDataViaDataProvider()
        
        if(self.enablePullToUpdate)
        {
            refreshControl = UIRefreshControl()
            self.tableView.addSubview(refreshControl!)
            refreshControl?.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        }
        
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let cellClassMap = cellNameMapForBase()
        for nibName in cellClassMap
        {
            self.tableView?.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
        
        let tapGestureBackground = UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped(_:)))
        tapGestureBackground.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureBackground)
        
        self.alreadyInitial = true
    }
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
    func loadTableDataViaDataProvider()
    {
        self.tableData = self.dataProvider?.getTableData() ?? [:]
        //let tableData = self.tableData
        //print(tableData)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.loadTableDataViaDataProvider()
        //self.tableView?.reloadData()
    }
    
    func getCellByIdentify(identifier:String,indexPath:IndexPath) -> BaseTableCell? {
        
        if(identifier == "")
        {
            //NSLog("Warning: getCellByIdentify identifier is empty, use BaseTableCell as default")
            let  cell = BaseTableCell.init()
            cell.baseDelegate = self
            //cell.backgroundColor = UIColor.red
            return cell
        }
        
        var cell = self.tableView?.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? BaseTableCell
        
        if (cell == nil)
        {
            cell = (Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first) as? BaseTableCell
        }
        
        if( cell == nil)
        {
            NSLog("Warning: getCellByIdentify identifier is empty, use BaseTableCell as default")
            cell = BaseTableCell.init()
            cell?.backgroundColor = UIColor.red
        }
        cell?.baseDelegate = self
        return cell
    }
    
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(self.tableData["list"] == nil)
        {
            return ""
        }
        let sections = self.tableData["list"] as! [[String:Any]]
        return sections[section]["secName"] as? String
    }
    
    func sectionCount()->Int
    {
        if(self.tableData["list"] == nil)
        {
            return 0
        }
        let sections = self.tableData["list"] as! [[String:Any]]
        return sections.count
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionCount()
    }
    
    func itemCountForSection(section:Int)->Int
    {
        if(self.tableData["list"] == nil)
        {
            return 0
        }
        let sections = self.tableData["list"] as! [[String:Any]]
        let listItems = sections[section]["list"] as! [[String:Any]]
        return listItems.count
    }
    
    func dataMapForSection(section: Int)->[String:Any]
    {
        let sections = self.tableData["list"] as! [[String:Any]]
        let section = sections[section]
        let dataMap = section["dataMap"]
        return dataMap as? [String : Any] ?? [:]
    }
    
    open func dataMapForCell(indexPath: IndexPath)->[String:Any]
    {
        let sections = self.tableData["list"] as! [[String:Any]]
        let listItems = sections[indexPath.section]["list"] as! [[String:Any]]
        
        if(listItems.count <= indexPath.row)
        {
            return [:]
        }
        return listItems[indexPath.row]
    }
    
    var mapAttachedVCs:[String:BaseVC] = [:]
    
    func indexPathToString(indexPath:IndexPath)->String
    {
        return String(indexPath.section) + "_" + String(indexPath.row)
    }
    
    func getAttachedVcFromCache(indexPath:IndexPath)->BaseVC?
    {
        return mapAttachedVCs[indexPathToString(indexPath: indexPath)]
    }
    
    open func getBaseVcForCell(indexPath:IndexPath)->BaseVC?
    {
        var attachedVC = getAttachedVcFromCache(indexPath: indexPath)
        
        let dataMapCell = self.dataMapForCell(indexPath: indexPath)
        let dataAttachedVC = dataMapCell["attachedVC"] as? dataMapObj
        if(dataAttachedVC == nil)
        {
            return nil
        }
        
        let attachedIdentity = dataAttachedVC?["attachedIdentity"] as? String ?? ""
        let attachedNibName = dataAttachedVC?["attachedNibName"] as? String ?? ""
        
        let dataMapForAttachedVC = dataAttachedVC?["data"] as? dataMapObj
        
        if(attachedVC == nil)
        {
            attachedVC = getAttachedVC(attachedIdentity: attachedIdentity,attachedNibName:attachedNibName)
            mapAttachedVCs[indexPathToString(indexPath: indexPath)] = attachedVC!
        }
        
        if(attachedVC != nil && dataMapForAttachedVC != nil)
        {
            attachedVC?.dataMap = dataMapForAttachedVC!
            attachedVC?.dataMap["attachedIdentity"] = attachedIdentity
        }
        
        return attachedVC
    }
    
    func getAttachedVC(attachedIdentity:String,attachedNibName:String)->BaseVC?
    {
        let implementType = getAttachVcByClassIdentity(attachedIdentity: attachedIdentity)
        let newAttachedVC = implementType?.init(nibName: attachedNibName, bundle: nil) ?? nil
        return newAttachedVC as? BaseVC
    }
    
    open func getAttachVcByClassIdentity(attachedIdentity:String)->UIViewController.Type?
    {
        return BaseVC.self
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
                //Remove all subviews
                //for view in viewBase!.subviews{
                //    view.removeFromSuperview()
                //}
                
                //baseVC!.view.removeFromSuperview()
                baseVC?.view.removeFromSuperview()
                viewBase!.addSubview(baseVC!.view)
                baseVC!.view.frame = CGRect.init(x: 0, y: 0, width: viewBase!.frame.size.width, height: viewBase!.frame.size.height)
            }
            
        }
        
        
        cell?.layoutIfNeeded()
        return cell!
    }
    
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemCountForSection(section: section)
    }
    
    
    //Featch Data
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            if(self.baseDataPageInfo.haveMore())
            {
                self.doFetchListData()
            }
        }
    }
    
    func doFetchListData(){
        let total = self.baseDataPageInfo.getTotal()
        if(total == 0)
        {
            return
        }
        
        if(!self.baseDataPageInfo.haveMore())
        {
            return
        }
        
        if(self.isLoadingShow == true)
        {
            return
        }
        
        self.tableDataProvider?.showEmpty = false
        fetchListDataImp()
    }
    
    func fetchListDataImp(){
        print("fetchListDataImp not implement")
    }
    
    var tableDataProvider:UITableDataProvider?
    {
        get{
            return self.dataProvider as? UITableDataProvider
        }
    }
}
