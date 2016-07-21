//
//  Core.swift
//  MenuStorage
//
//  Created by Joel Male on 21/07/2016.
//  Copyright © 2016 Joel Male. All rights reserved.
//

import Foundation

func getFreeSize() -> Int64? {
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    if let dictionary = try? NSFileManager.defaultManager().attributesOfFileSystemForPath(paths.last!) {
        if let freeSize = dictionary[NSFileSystemFreeSize] as? NSNumber {
            return freeSize.longLongValue
        }
    }else{
        print("Error Obtaining System Memory Info:")
    }
    return nil
}

func getTotalSize() -> Int64?{
    let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
    if let dictionary = try? NSFileManager.defaultManager().attributesOfFileSystemForPath(paths.last!) {
        if let freeSize = dictionary[NSFileSystemSize] as? NSNumber {
            return freeSize.longLongValue
        }
    }else{
        print("Error Obtaining System Memory Info:")
    }
    return nil
}