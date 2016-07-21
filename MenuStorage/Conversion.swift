//
//  Conversion.swift
//  MenuStorage
//
//  Created by Joel Male on 21/07/2016.
//  Copyright © 2016 Joel Male. All rights reserved.
//

import Foundation

func convertBytesToGb(bytes: Int64) -> Int64? {
    let bytesInGb = bytes / 1024 / 1024 / 1024
    return bytesInGb
}

func convertBytesToMb(bytes: Int64) -> Int64? {
    let bytesInMb = bytes / 1024 / 1024
    return bytesInMb
}