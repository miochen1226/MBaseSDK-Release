//
//  MBAuthorCenter.swift
//  MBaseSDK
//
//  Created by mio on 2020/5/6.
//  Copyright © 2020 mio. All rights reserved.
//

import UIKit


public class MBAuthorCenter: NSObject {
    static var mapAuthors: [Int:MBAuthor] = [-1:MBAuthor(authorId: -1, name: "Unassigned")]
    
    public class func getAuthors() -> [MBAuthor] {
        return Array(mapAuthors.values)
    }
    
    public class func insertAuthor(author: MBAuthor) {
        mapAuthors[author.authorId] = author
    }
    
    public class func getAuthorById(authorId: Int) -> MBAuthor {
        return mapAuthors[authorId] ?? MBAuthor(authorId: -1, name: "")
    }
}
