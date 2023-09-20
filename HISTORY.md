# MBaseSDK
## 設計概念
將每個專案常使用的實作併入基礎SDK Class
主要以ViewController為一完整單位 方便進行重複利用
## 每個專案開發都常見會做的事
    - 多國語系文字
    - TableView控件
    - VC元件堆疊
    - 頁面跳轉
    - 圓弧狀控件

# 實現準則
- 不過度複寫產生一堆包裝元件 
- 低使用學習門檻
- 用很簡單的方法

# 多國語系文字相關
### BaseDataVC
- [實作原因]
    - 一般傳統作法為 VC 內加入IBOutlet,然後呼叫控件對應setText   
    - 使用xib內建多國語系會產生很多散落的string table 且命名為無意義id 不利於集體送翻譯
- [解決思路]
    - 以ViewController為單位 建設一個文字自動套入對應控件的VC
- [實作內容]
    -  一個繼承自ViewController的class
    -  有一個hashMap存放 [Identifier:文字] 對應表
    -  viewDidLayoutSubviews裡面實作 
            "對自己的subviews執行從hashMap抓取對應文字填入" 
    - [使用步驟] 
        - 在xib中把控件的identifier填上自己命名的id
        - 在hashMap加入想顯示的文字 
        - 呼叫頁面刷新
            當文字有需要變動時(ex:動態切換語系) 更新hashMap內文字, 呼叫VC刷新 

- [使用起來像這樣]
    ```swift
    //MyBaseDataVC.swift
    class MyBaseDataVC: BaseDataVC {
        override func viewDidLoad() {
            super.viewDidLoad()
            self.dataMap = ["btnTest":"Push me"]
        }
    }
    ```
    
### BaseVC
- [實作原因]
    - 想把控制文字內容工作抽離VC
- [解決思路]
    - 寫一個class 專職提供BaseDataVC所需的文字內容hashMap,資料變動時通知VC刷新
- [實作內容]
    - 有一個 optional 的變數 UIDataProvider  
    - 讓VC透過Observer訂閱 UIDataProvider物件
    - [使用步驟] 
        - 使用者繼承 UIDataProvider 自行實作資料操作邏輯
        - 呼叫頁面刷新
            UIDataProvider.notifyDataChange() 

- [使用起來像這樣]
    ```swift
    //MyDataProvider.swift
    class MyDataProvider:UIDataProvider {
        override func getDataMap() -> dataMapObj {
        return ["labelTitle":"This is Title",
                "btnTest":"Push me"]
    }
    
    //MyVC.swift
    class MyVC: BaseVC {
        let myDataProvider = MyDataProvider()
        override func viewDidLoad() {
            super.viewDidLoad()
            self.dataProvider = myDataProvider
        }
    }
    ```
    
### BaseListVC
- [實作原因]
    - 一般傳統作法為 對tableview註冊 tableViewCell class, dequeueReusableCell拿出cell再賦予文字
    - 處理TableView包含不同cell類型的混合
- [解決思路]
    - 使用UIDataProvider 提供一個畫面描述所需資料 包含cell的xib name 
- [實作內容]
    - 繼承自BaseVC , 內部放一個等大的 UITableView
    - 把常見的必須實作方法在 BaseListVC內部完成
    - 讀取來自UIDataProvider的hashMap,依照所描述產生cell 加入 TableView 中
    - [使用步驟] 
        - 使用者繼承 UIDataProvider 自行實作資料操作邏輯
        - 呼叫頁面刷新
            UIDataProvider.notifyDataChange() 

- [使用起來像這樣]
    - MyBaseListVC.swift
        ```swift
        class MyBaseListVC: BaseListVC {
        let myTableDataProvider = MyTableDataProvider()
        override func viewDidLoad() {
            super.viewDidLoad()
            self.dataProvider = myTableDataProvider
        }
        
        //這例子提供兩種layout
        //初始化時BaseListVC會來問, 返回兩個xib name
        //Class為BaseTableCell ,也是屬於給他hashMap會自己填充文字的
        override func cellNameMapForBase() -> [String] {
            return ["MyBaseListCell","EmptyCell"]
        }
        
        //可在Cell實現自動高度計算 就不需要override這方法
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            let cellData = super.dataMapForCell(indexPath: indexPath)
            let cellNib = cellData["nibName"] as? String ?? ""
            if cellNib == "EmptyCell" {
                return self.view.frame.height
            }
            return 100
        }
    
        //操作DataProvider, 不一定要放VC內
        func cleanItems() {
            myTableDataProvider.cleanItems()
        }
        
        func insertItems() {
            for i in 0..<1 {
                let itemId = String(i)
                let title = String(i) + "." + "Title"
                let descript =  "descript-" + String(i)
                //Cell上的圖片
                let imageUrl = "image_url" + String(i)
                myTableDataProvider.addItem(itemId: itemId, title: title, descript: descript, imageUrl: imageUrl)
            }
            myBaseListVC_Data.notifyDataChange()
        }
        ```
    - MyTableDataProvider的輸出
        ```swift
            ["secName":"sec",
             "list":[ 
                    ["nibName":"MyBaseListCell",
                     "itemId":"0",
                     "title":"0.Title",
                     "descript":"descript-0",
                     "imageUrl":"imageUrl-0"
                    ],
                    ["nibName":"MyBaseListCell",
                     "itemId":"1",
                     "title":"1.Title",
                     "descript":"descript-1",
                     "imageUrl":"imageUrl-1"
                    ]
            ]
        ```
    - MyTableDataProvider.swift
        ```swift
        class MyTableDataProvider: UIDataProvider {
            private var items:[dataMapObj] = []
            func cleanItems() {
                items.removeAll()
                self.notifyDataChange()
            }
        
            func addItem(itemId: String, title: String, descript: String, imageUrl: String) {
                var data = dataMapObj.init()
                data["itemId"] = itemId
                data["labelTitle"] = title
                data["labelDescript"] = descript
                data["ivIcon"] = imageUrl
                self.items.append(data)
            }
        
            override func getTableData() -> [String : Any] {
                var secArray:[dataMapObj] = []
                var sec_1_node:dataMapObj = ["secName":""]
                sec_1_node["dataMap"] = []
                var cellArray:[dataMapObj] = []
                for item in self.items {
                    var itemData = item
                    itemData["nibName"] = "MyBaseListCell"
                    cellArray.append(itemData)
                }
                
                if self.items.count == 0 {
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

# VC元件堆疊
- [實作原因]
    - 透過上述的實作可以得到 單元資料完整的 ViewController class接下來要來重複使用他
    - 例如 實現了一個繼承自BaseListVC 的 CustomerListVC (選取顧客列表), 在兩個頁面中都有這個元件
    - BaseTableList實作中也有這部分的實現  在TableViewCell上 由data hash指定要粘貼的VC+所屬data
- [解決思路]
    - 在 VC_A 中 跟 VC_B 的 view 黏上 CustomerListVC 的view 
    - 把 CustomerListVC加入 VC_A, VC_B 的childViewController
    
- [實作內容]
    - 實作掛上VC view 的方法
    - 根據ID取得 subViewController
    - [使用步驟] 
        - 在VC_A 上拉一個 View(想黏貼上的範圍)
        - 呼叫方法 appendViewController 實作在BaseDataVC

- [使用起來像這樣]
    - VC_A.swift
        ```swift
        class MainFunctionMenuVC: BaseDataVC {
            @IBOutlet weak var viewList: UIView!
            override func viewDidLoad() {
                super.viewDidLoad()
                //建立CustomerListVC 並在viewList區域黏上 CustomerListVC的view
                //CustomerListVC實體會掛載在BaseDataVC中
                super.appendViewController(type: CustomerListVC.self, nibName: "CustomerListVC", controlId: "CustomerListVC_ID", to: self.viewList)
            }
        }
        //取出來用
        func test() {
            let customerListVC = super.getSubViewControlByID("CustomerListVC_ID") as? CustomerListVC
            customerListVC?.reload()
        }
        ```
    
## 頁面跳轉
- [實作原因]
        - 在專案中常常會使用到頁面跳轉 navi Push / present, 每次都在那邊 class init太麻煩了
- [解決思路]
    - 如果使用一個代號 呼叫方法就幫我建立 VC 然後推過去就太棒了( "CustomerPage" 推過去 )
    
- [實作內容]
    - 實作BasePageVC require func 回報自己的代號
    - APP初始時由PageTool scan所有BasePageVC衍生class 建立代號與VC class的 hashMap
    - 使用delegate實現畫面返回資料回吐
    - [使用步驟] 
        - 呼叫方法 PageTool.doPushPage/PageTool.doPresentPage

- [使用起來像這樣]
    - MainPageVC.swift
        ```swift
        class MainPageVC {
            func doEnterCustomerPage() {
                //initData為要帶給CustomerPage的初始值,例如預設選取, 這部分使用者自定義
                PageTool.doPushPage(identity: "CustomerPage", initData: [:], vc: self) { outData in
                    //outData為CustomerPage選取後回傳的結果, 可自定義
                    let index = outData["index"] as? Int ?? -1
                    self.doShowCustomer(index: index)
                }
            }
        }
        ```
    - CustomerPageVC.swift
        ```swift
        class CustomerPageVC: BasePageVC {
            override class func getPageIdentity() -> String {
                return "CustomerPageVC"
            }
            override class func getPageNibName() -> String {
                return "CustomerPageVC"
            }
        }
        ```
        
## 圓弧狀控件
- [實作原因]
        - 這東西真的太常見了
- [解決思路]
    - 基礎實現RadiusView RadiusButton RadiusImageView
    
- [實作內容]
    - @IBInspectable 寫變數給 LayoutEdit 用填的去設定半徑/顏色/border
    - [使用步驟] 
        - 會面上拉 UIView , LayoutEdit 改class name 成基礎實現RadiusView,就會帶出參數欄位讓你填
