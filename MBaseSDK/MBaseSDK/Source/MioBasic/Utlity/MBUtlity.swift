//
//  MBUtlity.swift
//  MBaseSDK
//
//  Created by mio on 2020/5/6.
//  Copyright © 2020 mio. All rights reserved.
//

import UIKit

public class MBUtlity: NSObject {
    
    public static var haveDevPage: Bool = false
    public class func createDemoPage() -> MBDirectoryVC {
        let bundle = Bundle.init(for: MBDirectoryVC.self)
        let directoryVC = MBDirectoryVC.init(nibName: "MBDirectoryVC", bundle: bundle)
        return directoryVC
    }
    
    public class func prepareDemoPage() {
        haveDevPage = false
        let basePageVCs = MBRuntime.subclasses(of: BasePageVC.self)
        for vc in basePageVCs {
            let basePageVC = vc as? BasePageVC.Type
            basePageVC?.registerPageFactory()
            
            haveDevPage = true
        }
    }
}
