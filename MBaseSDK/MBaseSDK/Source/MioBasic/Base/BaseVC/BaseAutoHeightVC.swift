//
//  BaseAutoHeightVC.swift
//  Jurassic
//
//  Created by mio on 2019/9/15.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

open class BaseAutoHeightVC: BaseVC {

    @IBOutlet open weak var viewContent: UIView?
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //let width = viewContent?.frame.size.width ?? self.view.frame.size.width
        //let height = viewContent?.frame.size.height ?? self.view.frame.size.height
        
        //self.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    open func getPerferHeight()->CGFloat
    {
        self.viewDidLayoutSubviews()
        return viewContent?.frame.size.height ?? -1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
