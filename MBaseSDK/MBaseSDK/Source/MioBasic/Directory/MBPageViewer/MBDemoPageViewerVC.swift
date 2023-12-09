//
//  MBDemoPageViewerVC.swift
//  Jurassic
//
//  Created by mio on 2019/8/28.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

public class MBDemoPageViewerVC: BaseVC {
    @IBOutlet weak var viewPageArea:UIView!
    @IBOutlet weak var viewTemplate:UIView!
    @IBOutlet weak var viewTemplateContent:UIView!
    @IBOutlet weak var btnTemplate: UIButton!
    
    var inputTemplates:[PageDataTemplate] = []
    var currentTemplateID:String = ""
    var currentTemplateIndex = 0
    var identity:String = ""
    public override func viewDidLoad() {
        
        self.dataMap["labelIdentity"] = identity
        self.dataMap["btnPickerApply"] = "Apply"
        
        super.viewDidLoad()
        
        self.btnTemplate.isHidden = false
        self.viewPageArea.layer.borderWidth = 2
        self.viewPageArea.layer.borderColor = UIColor.gray.cgColor
        
        let pageInfo = PageFactory.sharedInstance.getPageInfoByIdentity(identity: identity)
        
        if pageInfo != nil {
            let nibName = pageInfo!.getNibName()
            let implementType = pageInfo!.getImplementType() ?? nil
            
            if implementType != nil {
                super.appendViewController(type: implementType!, nibName: nibName, controlId: "page_id", to: self.viewPageArea)
               
                //讀取pageIO
                let pageIoProtocol = super.getSubViewControlByID("page_id") as? PageIoProtocol
                
                for dataTemplates in pageIoProtocol?.getDataTemplates() ?? [] {
                    let identity = dataTemplates.name
                    if identity != "" {
                        self.inputTemplates.append(dataTemplates)
                    }
                }
                
                if self.inputTemplates.count > 0 {
                    self.btnTemplate.isHidden = false
                    initTemplatePicker()
                    applyDataTemplate(index: 0)
                }
                else {
                    self.btnTemplate.isHidden = true
                }
            }
        }
    }
    
    public func initTemplatePicker() {
        let myPickerView = UIPickerView(frame: CGRect(
            x: 0, y: 0,
            width: viewTemplateContent.frame.size.width, height: viewTemplateContent.frame.size.height))
        myPickerView.delegate = self
        myPickerView.dataSource = self
        self.viewTemplateContent.addSubview(myPickerView)
        LayoutTool.applyFitParent(view: self.viewTemplateContent, viewSub: myPickerView)
    }

    public func applyDataTemplate(index: Int) {
        let templateName = self.inputTemplates[index].name
        self.dataMap["btnTemplate"] = templateName
        
        let pageIoProtocol = super.getSubViewControlByID("page_id") as? PageIoProtocol
        
        let pageDataTemplate = self.inputTemplates[index]
        pageIoProtocol?.applyDataTemplate(pageDataTemplate: pageDataTemplate)
        
        super.getSubViewControlByID("page_id")?.viewDidLayoutSubviews()
        self.viewDidLayoutSubviews()
    }
    
    @IBAction func didTemplateBtnClicked(_ sender: Any) {
        self.viewTemplate.isHidden = false
    }
    
    @IBAction func didTemplateApplyBtnClicked(_ sender: Any) {
        self.viewTemplate.isHidden = true
        self.applyDataTemplate(index: self.currentTemplateIndex)
    }
}

extension MBDemoPageViewerVC:UIPickerViewDelegate, UIPickerViewDataSource {
   //TemplatePicker
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.inputTemplates.count
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int, forComponent component: Int)
        -> String? {
            return self.inputTemplates[row].name
    }
    
    public func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int, inComponent component: Int) {
        self.currentTemplateIndex = row
    }
}
