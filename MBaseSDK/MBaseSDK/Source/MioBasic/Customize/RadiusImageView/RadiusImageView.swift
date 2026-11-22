//
//  RadiusImageView.swift
//  jourdenessSPA
//
//  Created by mio on 2019/3/21.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

@IBDesignable
@objc open class RadiusImageView: UIImageView {

    var _borderWidth:CGFloat = 0
    @IBInspectable var borderWidth:CGFloat {
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
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
    
    @IBInspectable var radius:CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            self.layoutSubviews()
        }
    }
}
