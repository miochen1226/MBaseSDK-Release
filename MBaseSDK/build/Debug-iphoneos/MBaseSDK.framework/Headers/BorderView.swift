//
//  BorderView.swift
//  Jurassic
//
//  Created by mio on 2019/9/17.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

@IBDesignable
@objc open class BorderView: UIView {

    @IBInspectable var borderWidth:CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            self.layoutSubviews()
        }
    }
    
    @IBInspectable var borderColor:UIColor? {
        get {
            if(layer.borderColor != nil)
            {
                return UIColor(cgColor: layer.borderColor!)
            }
            else
            {
                return UIColor.clear
            }
        }
        set {
            layer.borderColor = newValue?.cgColor
            self.layoutSubviews()
        }
    }

}
