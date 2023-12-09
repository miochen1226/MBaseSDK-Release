//
//  BaseDataView.swift
//  MBaseSDK
//
//  Created by mio on 2019/3/23.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

@objc open class BaseDataVC: UIViewController,DFProtocal {

    open var dataMap: [String : Any] = [:]
    
    var vcMap:[String:Any] = [:]
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func reloadData()
    {
        self.viewDidLayoutSubviews()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DataFillTool.checkAndFillData(self.view,dataMap: self.dataMap)
        
        //Update all view frame in vcMap
        let VCs = vcMap.map { $0.1 }
        for item in VCs
        {
            let vc = item as! UIViewController
            let parent = vc.view.superview
            if(parent != nil)
            {
                vc.view.frame = CGRect.init(x: 0, y: 0, width: parent!.frame.size.width, height: parent!.frame.size.height)
            }
        }
    }
    
    public func appendViewController(type:UIViewController.Type,nibName:String,controlId:String,to:UIView)
    {
        let vc = type.init(nibName: nibName, bundle: nil)
        to.addSubview(vc.view)
        vc.view.frame = CGRect.init(x: 0, y: 0, width: to.frame.size.width, height: to.frame.size.height)
        vcMap[controlId] = vc
        self.addChild(vc)
    }
    
    public func appendViewController(type:UIViewController.Type,nibName:String,controlId:String,to:UIView,dataProvider:UIDataProvider)
    {
        let vc = type.init(nibName: nibName, bundle: nil)
        to.addSubview(vc.view)
        vc.view.frame = CGRect.init(x: 0, y: 0, width: to.frame.size.width, height: to.frame.size.height)
        
        let baseVC:BaseVC? = vc as? BaseVC
        baseVC?.dataProvider = dataProvider
        vcMap[controlId] = vc
        self.addChild(vc)
    }
    
    
    public func appendNavigationController(viewController:UINavigationController,controlId:String,to:UIView)
    {
        to.addSubview(viewController.view)
        vcMap[controlId] = viewController
        self.addChild(viewController)
    }
    
    public func getSubViewControlByID(_ controlId:String)->UIViewController?
    {
        return vcMap[controlId] as? UIViewController
    }
    
    public func getSubNavigationControllerByID(_ controlId:String)->UINavigationController?
    {
        return vcMap[controlId] as? UINavigationController
    }
    
    public func removeSubViewControlByID(_ controlId:String)
    {
        let vc:UIViewController? = vcMap[controlId] as? UIViewController
        vc?.view.removeFromSuperview()
        vcMap[controlId] = nil
    }
    
    public func cleanAllSubVC()
    {
        for controlId in vcMap.keys
        {
            self.removeSubViewControlByID(controlId)
            
        }
        self.vcMap.removeAll()
    }
}
