
## MBaseSDK
* MBaseSDK offer some powerful class and tool doing routine things for you!

## Function
* Data Mapping for controls in your view	
	* UILabel (set text)
	* UIButton (set text)
	* UITextField (set text)
	* UITextView (set text)
	* UIImageView (set image UIImage or Image URL)
	
* Make your customize ViewControl more reusable
* Easy tool for navigate Page to another Page
* Build-in DemoPage for demonstrate all pages you developed

## Add to the Podfile
```objc 
pod 'MBaseSDK'
```

## Using MBaseSDK
### BaseVC for Data Mapping
xib file \
![image](https://github.com/miochen1226/MBaseSDK-Release/blob/master/snapshots/xib_id_example.png)

Swift file
```swift
class MyVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataMap = ["btnTest":"Push me"]
    }
}
```

### UIDataProvider for BaseVC 

MyDataProvider.swift
```swift
class MyDataProvider:UIDataProvider
{
    var labelText = "UIDataProviderDemoVC"
    var imageUrl = "https://cdn.carnews.com/thumb/1236x989/article/08f23f78-e682-11e9-a795-42010af00004/Dn8Lmhw6XCg8.jpg"
    override func getDataMap() -> dataMapObj {
        return ["labelTitle":labelText,
                "btnTest":"Push me",
                "ivImage":imageUrl]
    }
}
```
UIDataProviderDemoVC.swift
```swift
class UIDataProviderDemoVC: BaseVC {
    let myDataProvider = MyDataProvider()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataProvider = myDataProvider
    }
    
    //update values
    @IBAction func didTestClicked(_ sender:Any){
        myDataProvider.labelText = "Pressed"
        myDataProvider.imageUrl = "https://fate-15th.com/assets/img/pc/img_main.jpg"
        myDataProvider.notifyDataChange()
    }
}
```

### BaseListVC for Data Mapping

MyBaseListVC.swift
```swift
class MyBaseListVC: BaseListVC {
    
    let myBaseListVC_Data = MyBaseListVC_Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataProvider = myBaseListVC_Data
        // Do any additional setup after loading the view.
    }

    override func cellNameMapForBase() -> [String] {
        return ["MyBaseListCell","EmptyCell"]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellData = super.dataMapForCell(indexPath: indexPath)
        
        let cellNib = cellData["nibName"] as? String ?? ""
        if(cellNib == "EmptyCell")
        {
            return self.view.frame.height
        }
        return 100
    }
    
    func insertItems()
    {
        for i in 10...30 {
            let itemId = String(i)
            let title = String(i) + "." + "Title"
            let descript =  "descript-" + String(i)
            let imageUrl = "https://www.fate-sn.com/assets_hf3/img/special/countdown/HF3-countdown100_"+String(i)+".jpg"
            myBaseListVC_Data.addItem(itemId: itemId, title: title, descript: descript, imageUrl: imageUrl)
            
        }
        myBaseListVC_Data.notifyDataChange()
    }
    
    func cleanItems()
    {
        myBaseListVC_Data.cleanItems()
    }
}
```
MyBaseListVC_Data.swift
```swift
class MyBaseListVC_Data: UIDataProvider {
    
    private var items:[dataMapObj] = []
    
    var showEmpty:Bool = true
    {
        didSet{
            self.notifyDataChange()
        }
    }
    
    func cleanItems()
    {
        items.removeAll()
        self.notifyDataChange()
    }
    
    func addItem(itemId:String,title:String,descript:String,imageUrl:String)
    {
        var data = dataMapObj.init()
        data["itemId"] = itemId
        data["labelTitle"] = title
        data["labelDescript"] = descript
        data["ivIcon"] = imageUrl
        self.items.append(data)
    }
    
    override init() {
        super.init()
        self.items.removeAll()
    }
    
    override func getTableData() -> [String : Any] {
        
        var secArray:[dataMapObj] = []
        var sec_1_node:dataMapObj = ["secName":""]
        sec_1_node["dataMap"] = []
        
        var cellArray:[dataMapObj] = []
        
        
        for item in self.items
        {
            var itemData = item
            itemData["nibName"] = "MyBaseListCell"
            cellArray.append(itemData)
        }
        
        if(self.showEmpty && self.items.count == 0)
        {
            var itemDataEmpty = dataMapObj()
            itemDataEmpty["nibName"] = "EmptyCell"
            itemDataEmpty["labelEmpty"] = "EMPTY"
            cellArray.append(itemDataEmpty)
        }
        
        sec_1_node["list"] = cellArray
        secArray.append(sec_1_node)
        
        var tableData:dataMapObj = [:]
        tableData["list"] = secArray
        return tableData
    }
}
```

### Reusing your BaseVC subclass

Attach your viewController to a view
```swift
@IBOutlet weak var viewList:UIView!
func AttachMyBaseListVC(){
    super.appendViewController(type: MyBaseListVC.self, nibName: "MyBaseListVC", controlId: "MyBaseListVC", to: self.viewList)
}
```
Get your viewController by **controlId**
```swift
@IBAction func didCleanClicked(_ sender:Any){
    let myBaseListVC = super.getSubViewControlByID("MyBaseListVC") as? MyBaseListVC
    myBaseListVC?.cleanItems()
}
```

### Using BasePageVC
* Inherit **BasePageVC** and provide require method
```swift
class MyVC: BasePageVC {

    override class func getPageIdentity() -> String {
        return "2.UIDataProvider Demo"
    }
    
    override class func getPageNibName() -> String {
        return "UIDataProviderDemoVC"
    }
    
    override class func getAuthor() -> MBAuthor {
        return AuthorDef.Mio
    }
}

```
### Navigate Page to another Page
* Push page
```swift
@IBAction func didPushClicked(_ sender:Any){
    PageTool.doPushPage(identity: "1.BaseVC Demo", initData: [:], vc: self, dismissResult: nil)
}
```
* Present Page
```swift
@IBAction func didPresentClicked(_ sender:Any){
    PageTool.doPresentPage(identity: "1.BaseVC Demo", initData:initData, vc: self, dismissResult: nil)
}
```

### Build-In DemoVC
* call **MBUtlity.prepareDemoPage()** to join all **BasePageVC** subclasses to demo page in your AppDelegate.swift
```swift
func scanAndBuildPages(){
    MBAuthorCenter.insertAuthor(author: AuthorDef.Mio)
    MBUtlity.prepareDemoPage()
}
```
* call **MBUtlity.createDemoPage()** to get viewController
```swift
func enterDemoStage(){
    let pageVC = MBUtlity.createDemoPage()
    let naviVC = UINavigationController.init(rootViewController: pageVC)
    naviVC.navigationBar.isHidden = true
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = naviVC
    self.window?.makeKeyAndVisible()
}
```


## Referance
* Demo Project
https://github.com/miochen1226/MBaseDemo
* Page class code generator
https://github.com/miochen1226/MBasePagesGenerator
