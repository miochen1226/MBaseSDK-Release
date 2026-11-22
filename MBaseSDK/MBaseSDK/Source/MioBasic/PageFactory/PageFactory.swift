//
//  PageFactory.swift
//  Jurassic
//
//  Created by mio on 2019/8/28.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

/*
public enum Author : Int {
    case unassign = 0
    case mio = 1
};
*/

public class MBAuthor{
    var authorId = 0
    var name = ""
    
    public func getName()->String
    {
        return name
    }
    
    public init(authorId:Int,name:String) {
        self.authorId = authorId
        self.name = name
    }
}

public class PageInfo{
    private var identiy:String = ""
    private var nibName:String?
    private var author:MBAuthor?
    private var implementType:UIViewController.Type?
    private var api:Bool = false
    
    public func haveImplement()->Bool
    {
        if(nibName != "" && implementType != nil)
        {
            return true
        }
        
        return false
    }
    
    public func haveApiImplement()->Bool
    {
        return api
    }
    
    public func getAuthor()->MBAuthor?
    {
        return author
    }
    
    public func getAuthorName()->String
    {
        return author?.name ?? "Unassigned"
    }
    
    public func getAuthorId()->Int
    {
        return author?.authorId ?? -1
    }
    
    public func getIdentiy()->String
    {
        return identiy
    }
    
    public func getImplementClassName()->String
    {
        let implementType = getImplementType()
        if(implementType == nil)
        {
            return "Not implement"
        }
        return String(describing: implementType)
    }
    
    public func getNibName()->String
    {
        return nibName ?? ""
    }
    
    public func getImplementType()->UIViewController.Type?
    {
        return implementType
    }
    
    public func setImplementType(impType:UIViewController.Type)
    {
        implementType = impType
    }
    
    public init(identiy:String,type:UIViewController.Type? = nil,nibName:String? = "",api:Bool? = false)
    {
        self.identiy = identiy
        self.nibName = nibName ?? ""
        self.implementType = type
        self.api = api ?? false
    }
    
    public func updatePageInfo(author:MBAuthor,type:UIViewController.Type? = nil,nibName:String? = "",api:Bool? = false)
    {
        self.author = author
        self.implementType = type
        self.nibName = nibName
        self.api = api ?? false
    }
    
    public func createPage()->UIViewController?
    {
        let vc = self.implementType?.init(nibName: self.nibName, bundle: nil) ?? nil
        return vc
    }
}

public class PageFactory: NSObject {
    public static let sharedInstance = PageFactory()
    public static var developingIdentity = ""
    private var hashMapPageInfo:[String:PageInfo] = [:]
    
    private override init() {
        super.init()
    }
    
    public func getPageInfoByIdentity(identity:String)->PageInfo?
    {
        return self.hashMapPageInfo[identity]
    }
    
    public func getPageInfosByAuthor(author:MBAuthor)->[PageInfo]
    {
        var pageInfos:[PageInfo] = []
     
        for pageInfo in self.hashMapPageInfo.values
        {
            if(pageInfo.getAuthorId() == author.authorId)
            {
                pageInfos.append(pageInfo)
            }
        }
        pageInfos.sort(by:{ $0.getIdentiy() < $1.getIdentiy() })
        return pageInfos
    }
    
    public func addPage(_ identiy:String)
    {
        let pageInfo = PageInfo.init(identiy: identiy)
        if(identiy != "")
        {
            hashMapPageInfo[identiy] = pageInfo
        }
    }
    
    public func updatePageInfo(identiy:String,author:MBAuthor,type:UIViewController.Type? = nil,nibName:String? = "",api:Bool? = false)
    {
        let pageInfo = hashMapPageInfo[identiy]
        pageInfo?.updatePageInfo(author: author, type: type, nibName: nibName,api:api ?? false)
    }
    
}
