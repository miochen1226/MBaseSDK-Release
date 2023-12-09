//
//  FakeDataProvider.swift
//  MBaseSDK
//
//  Created by mio on 2019/4/15.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

class FakeDataProvider: UIDataProvider {
    override func getTableData()->[String:Any]
    {
        let sec_1 = [
            ["title":"","info":""],
            ["title":"","info":""]]
        let sec_2 = [
            ["title":"","info":""],
            ["title":"","info":""],
            ["title":"","info":""]]
        
        let sec_3 = [
            ["title":"","info":""],
            ["title":"","info":""],
            ["title":"","info":""]]
        
        let sec_1_node:[String:Any] = ["secName":"","list":sec_1]
        let sec_2_node:[String:Any] = ["secName":"","list":sec_2]
        let sec_3_node:[String:Any] = ["secName":"","list":sec_3]
        return ["list": [sec_1_node,sec_2_node,sec_3_node]]
    }
}
