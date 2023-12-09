//
//  BaseDataProtocol.swift
//  MBaseSDK
//
//  Created by mio on 2019/3/23.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit
import Kingfisher

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        parentResponder = parentResponder!.next
        if let viewController = parentResponder as? UIViewController {
            return viewController
        }
        return nil
    }
}

class DataFillTool:NSObject{

    class func checkAndFillData(_ view:UIView,dataMap:[String : Any]) {
        fillUIData(view,dataMap: dataMap)
    }
    
    class func fillLabel(label:UILabel,dataMap:[String : Any]) {
        let controlID:String! = label.accessibilityIdentifier ?? ""
        
        if (controlID == "") {return}
        let data = dataMap[controlID]
        if( data == nil) {
            label.text = controlID
            return
        }
        
        let stringValue:String? = data as? String ?? nil
        if stringValue != nil
        {
            label.text = stringValue
        }
    }
    
    class func fillTextField(textField:UITextField,dataMap:[String : Any]) {
        let controlID:String! = textField.accessibilityIdentifier ?? ""
        
        if (controlID == "") {return}
        let data = dataMap[controlID]
        if( data == nil) {
            textField.text = controlID
            return
        }
        
        let stringValue:String? = data as? String ?? nil
        if stringValue != nil
        {
            textField.text = stringValue
        }
    }
    
    class func fillTextView(textView:UITextView,dataMap:[String : Any]) {
        let controlID:String! = textView.accessibilityIdentifier ?? ""
        
        if (controlID == "") {return}
        let data = dataMap[controlID]
        if( data == nil) {
            textView.text = controlID
            return
        }
        
        let stringValue:String? = data as? String ?? nil
        if stringValue != nil
        {
            textView.text = stringValue
        }
    }
    
    class func fillImage(imageView:UIImageView,dataMap:[String : Any]) {
        let controlID:String! = imageView.accessibilityIdentifier ?? ""
        
        if (controlID == "") {return}
        let data = dataMap[controlID]
        if( data == nil) {
            return
        }
        
        let image:UIImage? = data as? UIImage ?? nil
        if image != nil
        {
            imageView.image = image
            return
        }
        
        let imageUrl:String? = data as? String ?? ""
        if(imageUrl != "")
        {
            let url = URL(string: imageUrl!)
            imageView.kf.setImage(with: url,placeholder: UIImage.init(named: "defaultImage"))
        }
        else
        {
            imageView.image = UIImage.init(named: "defaultImage")
        }
    }
    
    class func fillButton(button:UIButton,dataMap:[String : Any]) {
        let controlID:String! = button.accessibilityIdentifier ?? ""
        
        if (controlID == "") {return}
        let data = dataMap[controlID]
        if( data == nil) {
            button.setTitle(controlID, for: .normal)
            button.setTitle(controlID, for: .highlighted)
            button.setTitle(controlID, for: .disabled)
            button.setTitle(controlID, for: .selected)
            return
        }
        
        let stringValue:String? = data as? String ?? nil
        if stringValue != nil
        {
            button.setTitle(stringValue, for: .normal)
            button.setTitle(stringValue, for: .highlighted)
            button.setTitle(stringValue, for: .disabled)
            button.setTitle(stringValue, for: .selected)
        }
    }
    
    class func fillUIData(_ viewParent:UIView,dataMap:[String : Any]){
        for subView in viewParent.subviews
        {
            //VC已經自己處理
            let parentViewController = subView.parentViewController
            if(parentViewController != nil)
            {
                let baseDataCell:DFProtocal! = parentViewController! as? DFProtocal
                if(baseDataCell != nil)
                {
                    continue
                }
            }
            
            //View已經自己處理
            if(subView as? DFProtocal != nil)
            {
                continue
            }
            
            let lable = subView as? UILabel
            if( lable != nil)
            {
                fillLabel(label: lable!,dataMap: dataMap)
                continue
            }
            let button = subView as? UIButton
            if( button != nil)
            {
                fillButton(button: button!,dataMap: dataMap)
                continue
            }
            
            let textField = subView as? UITextField
            if( textField != nil)
            {
                fillTextField(textField: textField!,dataMap: dataMap)
                continue
            }
            
            let textView = subView as? UITextView
            if( textView != nil)
            {
                fillTextView(textView: textView!,dataMap: dataMap)
                continue
            }
            
            let imageView = subView as? UIImageView
            if( imageView != nil)
            {
                fillImage(imageView: imageView!,dataMap: dataMap)
                continue
            }
            self.fillUIData(subView,dataMap: dataMap)
        }
        viewParent.layoutIfNeeded()
    }
}
