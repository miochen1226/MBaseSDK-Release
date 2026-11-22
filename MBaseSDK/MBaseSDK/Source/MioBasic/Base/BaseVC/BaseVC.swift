//
//  BaseVC.swift
//  jourdenessSPA
//
//  Created by mio on 2019/3/23.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

@objc public protocol ShowLoadingDelegate {
    @objc optional func doAppendShowLoadingVC()
    @objc optional func doRemoveShowLoadingVC()
}

@objc open class BaseVC: BaseDataVC,UIDataProviderDelegate,ShowLoadingDelegate{
    var showLoadingDelegate:ShowLoadingDelegate? = nil
    public var isLoadingShow:Bool = false
    {
        didSet{
            if(self.isLoadingShow)
            {
                haneldRemoveShowLoadingVC()
                haneldAppendShowLoadingVC()
            }
            else
            {
                haneldRemoveShowLoadingVC()
            }
        }
    }
    
    open func haneldAppendShowLoadingVC()
    {
        self.showLoadingDelegate?.doAppendShowLoadingVC?()
    }
    
    open func haneldRemoveShowLoadingVC()
    {
        self.showLoadingDelegate?.doRemoveShowLoadingVC?()
    }
    
    open var dataOut:dataMapObj?
    open var ptDismissHandler:ptDismissResult = nil
    open func didDataUpdated() {
        DispatchQueue.main.async() {
            self.loadDataViaDataProvider()
            self.viewDidLayoutSubviews()
        }
    }
    
    deinit{
        self.dataProvider?.removeObserver(observer: self)
    }
    
    public var dataProvider:UIDataProvider?
    {
        didSet{
            dataProvider?.addObserver(observer: self)
            self.loadDataViaDataProvider()
            self.view.setNeedsLayout()
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        //self.dataProvider?.removeObserver(observer: self)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        self.dataProvider?.addObserver(observer: self)
    }
    
    var dataInit:dataMapObj?
    open func doInit(dataInit:dataMapObj)
    {
        self.dataInit = dataInit
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoadingDelegate = self
        self.dataProvider?.addObserver(observer: self)
        loadDataViaDataProvider()
        // Do any additional setup after loading the view.
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadDataViaDataProvider()
    {
        if(self.dataProvider != nil)
        {
            self.dataMap = self.dataProvider!.getDataMap()
        }
    }
    
    @IBAction open func didCloseClicked(_ sender:Any)
    {
        self.ptDismissHandler?(dataOut)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction open func didBackClicked(_ sender:Any)
    {
        self.ptDismissHandler?(dataOut)
        self.navigationController?.popViewController(animated: true)
    }

}
