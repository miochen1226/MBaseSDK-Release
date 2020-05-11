## MBaseSDK
* MBaseSDK offer some powerful class and tool doing routine things for you.

## Function
* Auto fill text to controls(UILabel,UITextField,UIButton....)
* Make your customize ViewControl more reuseful
* Easy tool for navigate Page to another Page
* Build-in DemoPage for demostrating all pages you developed

## Add to the Podfile
```objc 
pod 'MBaseSDK'
```

## How to use MBaseSDK
* BaseVC
  - Auto fill text from BaseVC.dataMap to controls(UILabel,UITextField,UIButton....)
```swift
class MyVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataMap = ["btnTest":"Push me"]
    }
}
```
## Referance
* Demo Project
https://github.com/miochen1226/MBaseDemo

