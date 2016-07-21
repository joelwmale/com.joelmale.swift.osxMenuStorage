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
    
    var updateTimer: NSTimer?
    // Default
    var updateFrequency : NSTimeInterval = 3.0;

    @IBAction func quitApplication(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }

    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var window: NSWindow!
    
    @IBAction func update5Seconds(sender: NSMenuItem) {
        updateTimer(5.0)
    }
    
    @IBAction func update20Seconds(sender: NSMenuItem) {
        updateTimer(20.0)
    }
    
    // Get to the main status bar for the OS
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    
    func updateMenu() {
        // Get the current free disk space
        let freeDiskSpace = convertBytesToGb(getFreeSize()!)
        
        // Get total space
        let totalDiskSpace = convertBytesToGb(getTotalSize()!)
        
        // Set the title that the user will see
        //statusItem.title = "Free Disk Space: \(freeDiskSpace!)GB / \(totalDiskSpace!)GB"
        statusItem.title = "My current update time is every \(updateFrequency) seconds"
        
        print("Updated menu")
    }
    
    func updateTimer(time : NSTimeInterval) {
        if (updateTimer != nil) {
            updateTimer!.invalidate()
        }
        updateFrequency = time
        updateTimer = NSTimer.scheduledTimerWithTimeInterval(time, target: self, selector: #selector(self.updateMenu), userInfo: nil, repeats: true)
    }

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        // Add the menu to our status bar item
        statusItem.menu = statusMenu
        
        // Update the menu
        updateMenu()
        
        // Create a timer to call the update function
        updateTimer(updateFrequency)
    }


}

