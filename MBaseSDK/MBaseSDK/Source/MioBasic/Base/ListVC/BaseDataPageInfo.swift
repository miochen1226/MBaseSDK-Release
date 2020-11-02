//
//  BaseDataPageInfo.swift
//  Jurassic
//
//  Created by mio on 2019/11/20.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

class BaseDataPageInfo: NSObject {
    private var offset:Int64 = 0
    private var total:Int64 = 0
    private var params:dataMapObj = dataMapObj()
    
    func getOffset()->Int64
    {
        return self.offset
    }
    
    func getTotal()->Int64
    {
        return self.total
    }
    
    func update(offset:Int64,total:Int64)
    {
        self.offset = offset
        self.total = total
    }
    
    func setParam(key:String,value:Any)
    {
        params[key] = value
    }
    func getParam(key:String)->Any?
    {
        return params[key]
    }
    
    func haveMore()->Bool
    {
        if(total != -1 && total <= offset)
        {
            return false
        }
        else
        {
            return true
        }
    }
}
