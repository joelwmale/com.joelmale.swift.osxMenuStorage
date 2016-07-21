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
        let freeDiskSpace = convertBytesToGb(getFreeSize()!)
        
        // Get total space
        let totalDiskSpace = convertBytesToGb(getTotalSize()!)
        
        // Set the title that the user will see
        statusItem.title = "Free Disk Space: \(freeDiskSpace!)GB / \(totalDiskSpace!)GB"
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        // Add the menu to our status bar item
        statusItem.menu = statusMenu
        
        // Update the menu
        updateMenu()
        
        // Create a timer to call the update function
        _ = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(self.updateMenu), userInfo: nil, repeats: true)
    }


}

