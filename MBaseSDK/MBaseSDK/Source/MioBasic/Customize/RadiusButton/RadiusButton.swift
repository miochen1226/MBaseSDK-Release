//
//  RadiusButton.swift
//  jourdenessSPA
//
//  Created by mio on 2019/3/21.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

@IBDesignable
@objc open class RadiusButton: UIButton {
    var _borderWidth:CGFloat = 0
    var _enableV:Bool = false
    @IBInspectable var enableV:Bool {
        get {
            return _enableV
        }
        set {
            _enableV = newValue
            self.layoutSubviews()
        }
    }
    
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
        }
    }
    
    func showWithAnimation()
    {
        if(self.isHidden == false)
        {
            return
        }
        DispatchQueue.main.async() {
            self.alpha = 0
            self.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 1
                self.isHidden = false
                
            })
        }
    }
    
    open override var isEnabled: Bool{
        didSet{
            if(isEnabled)
            {
                self.alpha = 1
            }
            else
            {
                self.alpha = 0.5
            }
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if(self.isEnabled)
        {
            self.layer.borderWidth = _borderWidth
        }
        else
        {
            self.layer.borderWidth = 0
        }
        
        if(self._enableV)
        {
            centerVertically()
        }
    }
    
    func centerVertically(padding: CGFloat = 6.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
            return
        }

        let totalHeight = imageViewSize.height + titleLabelSize.height + padding

        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )

        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )

        self.contentEdgeInsets = UIEdgeInsets(
            top: 18.0,
            left: 0.0,
            bottom: 18.0,//titleLabelSize.height,
            right: 0.0
        )
    }
}
