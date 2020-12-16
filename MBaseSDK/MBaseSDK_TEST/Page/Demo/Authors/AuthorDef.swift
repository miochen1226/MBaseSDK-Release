//
//  AuthorDef.swift
//  MBaseTestBed
//
//  Created by mio on 2020/5/6.
//  Copyright © 2020 miochen. All rights reserved.
//

import UIKit
import MBaseSDK

public class AuthorDef {
    class var Mio:MBAuthor{
        get{
            return MBAuthor(authorId: 0, name: "Mio")
        }
    }
    
    /* Another Author
    class var John:MBAuthor{
        get{
            return MBAuthor(authorId: 1, name: "John")
        }
    }
    */
};
