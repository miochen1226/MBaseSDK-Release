//
//  CasherGiftSectionHeaderVC.swift
//  MBaseSDK
//
//  Created by mio on 2019/4/13.
//  Copyright © 2019 mio. All rights reserved.
//

import UIKit

public protocol BaseTableHeaderDelegate:AnyObject{
    func didHeaderClicked(tag:Int)
    func didHeaderButtonClicked(tag:Int,section:Int)
    func didHeaderButtonClickedWithData(data: [String : Any])
}


open class BaseTableHeader: BaseVC {
    func didButtonClick(tag: Int, data: [String : Any]) {
        self.delegate?.didHeaderButtonClickedWithData(data:data)
    }
    
    @IBOutlet weak var viewTabArea:UIView!
    open weak var delegate:BaseTableHeaderDelegate?
    open override func viewDidLoad() {
        super.viewDidLoad()        
        // Do any additional setup after loading the view.
    }
    
    public required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    @IBAction func didHeaderClicked(_ sender:Any)
    {
        self.delegate?.didHeaderClicked(tag: self.view.tag)
    }
    
    @IBAction func didHeaderButtonClicked(_ sender:Any)
    {
        let button:UIButton = sender as! UIButton
        self.delegate?.didHeaderButtonClicked(tag:button.tag,section: self.view.tag)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
