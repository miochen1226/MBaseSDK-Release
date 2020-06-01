//
//  BaseVC.swift
//  Pods-Atenore
//
//  Created by mio on 2020/5/20.
//

import UIKit

class BaseDataVC: UIViewController {}
class BaseVC: BaseDataVC {
    @IBAction func didCloseClicked(_ sender:Any)
    {
    }
    
    @IBAction func didBackClicked(_ sender:Any)
    {
    }
}
class BasePageVC: BaseVC {}
class BaseHolderVC: BaseVC {}

//List
class BaseListVC: BaseVC {
    @IBOutlet weak var tableView:UITableView!
}
class BaseTableCell: UITableViewCell {}
class BaseTableHeader: BaseVC {}
class BaseAutoHeightVC: BaseVC {
    @IBOutlet weak var viewContent: UIView?
}

//Collection
class BaseCollectionVC: BaseVC {
    @IBOutlet weak var collectionView:UICollectionView!
}
class BaseCollectionCell: UICollectionViewCell {}
