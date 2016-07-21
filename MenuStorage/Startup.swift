//
//  Startup.swift
//  MenuStorage
//
//  Created by Joel Male on 21/07/2016.
//  Copyright © 2016 Joel Male. All rights reserved.
//

import Foundation

func applicationIsInStartUpItems() -> Bool {
    return (itemReferencesInLoginItems().existingReference != nil)
}

func itemReferencesInLoginItems() -> (existingReference: LSSharedFileListItemRef?, lastReference: LSSharedFileListItemRef?) {
    let itemUrl : UnsafeMutablePointer<Unmanaged<CFURL>?> = UnsafeMutablePointer<Unmanaged<CFURL>?>.alloc(1)
    if let appUrl : NSURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath) {
        let loginItemsRef = LSSharedFileListCreate(
            nil,
            kLSSharedFileListSessionLoginItems.takeRetainedValue(),
            nil
            ).takeRetainedValue() as LSSharedFileListRef?
        if loginItemsRef != nil {
            let loginItems: NSArray = LSSharedFileListCopySnapshot(loginItemsRef, nil).takeRetainedValue() as NSArray
            print("There are \(loginItems.count) login items")
            let lastItemRef: LSSharedFileListItemRef = loginItems.lastObject as! LSSharedFileListItemRef
            for i in 0 ..< loginItems.count {
                let currentItemRef: LSSharedFileListItemRef = loginItems.objectAtIndex(i) as! LSSharedFileListItemRef
                if LSSharedFileListItemResolve(currentItemRef, 0, itemUrl, nil) == noErr {
                    if let urlRef: NSURL =  itemUrl.memory?.takeRetainedValue() {
                        //print("URL Ref: \(urlRef.lastPathComponent)")
                        if urlRef.isEqual(appUrl) {
                            return (currentItemRef, lastItemRef)
                        }
                    }
                } else {
                    print("Unknown login application")
                }
            }
            //The application was not found in the startup list
            return (nil, lastItemRef)
        }
    }
    return (nil, nil)
}

func toggleLaunchAtStartup() {
    let itemReferences = itemReferencesInLoginItems()
    let shouldBeToggled = (itemReferences.existingReference == nil)
    let loginItemsRef = LSSharedFileListCreate(
        nil,
        kLSSharedFileListSessionLoginItems.takeRetainedValue(),
        nil
        ).takeRetainedValue() as LSSharedFileListRef?
    if loginItemsRef != nil {
        if shouldBeToggled {
            if let appUrl : CFURLRef = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath) {
                LSSharedFileListInsertItemURL(
                    loginItemsRef,
                    itemReferences.lastReference,
                    nil,
                    nil,
                    appUrl,
                    nil,
                    nil
                )
                print("Application was added to login items")
            }
        } else {
            if let itemRef = itemReferences.existingReference {
                LSSharedFileListItemRemove(loginItemsRef,itemRef);
                print("Application was removed from login items")
            }
        }
    }
}