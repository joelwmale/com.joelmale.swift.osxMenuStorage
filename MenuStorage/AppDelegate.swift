//
//  AppDelegate.swift
//  MenuStorage
//
//  Created by Joel Male on 20/07/2016.
//  Copyright © 2016 Joel Male. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBAction func quitApplication(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var window: NSWindow!
    
    // Get to the main status bar for the OS
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    
    func updateMenu() {
        // Get the current free disk space
        let freeDiskSpace = getFreeSize()
        
        // Set the title that the user will see
        statusItem.title = "Free Disk Space: \(freeDiskSpace!)"
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Add the menu to our status bar item
        statusItem.menu = statusMenu
        
        // Update the menu
        updateMenu()
        
        // Create a timer to call the update function
        _ = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(self.updateMenu), userInfo: nil, repeats: true)
    }
    
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

}

