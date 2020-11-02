//
//  LayoutTool.swift
//  Jurassic
//
//  Created by mio on 2019/10/4.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

public class LayoutTool: NSObject {

    public class func applyFitParent(view:UIView,viewSub:UIView)
    {
        viewSub.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewSub)
        view.addConstraint(NSLayoutConstraint(item: viewSub, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: viewSub, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: viewSub, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: viewSub, attribute: .trailing, multiplier: 1.0, constant: 0.0))
    }
}
