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
    // Default update frequency
    var updateFrequency : NSTimeInterval = 30.0;
    
    // Preferences window
    lazy var windowController = windowNibName: "preferencesWindow"

    @IBAction func quitApplication(sender: NSMenuItem) {
        NSApplication.sharedApplication().terminate(self)
    }
    
    @IBOutlet weak var launchItem: NSMenuItem!
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var window: NSWindow!
    
    @IBAction func showPreferences(sender: NSMenuItem) {
        preferencesWindow.showWindow
    }
    
    @IBAction func update30Seconds(sender: NSMenuItem) {
        updateTimer(30.0)
    }
    
    @IBAction func update5Minutes(sender: NSMenuItem) {
        updateTimer(300.0)
    }
    
    @IBAction func launchAtLogin(sender: NSMenuItem) {
        if toggleLaunchAtStartup() {
            launchItem.title = "Remove from Login"
        } else {
            launchItem.title = "Start at Login"
        }
    }
    
    
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
        
        // Check if item is on startup already
        if checkStartupItem() {
            launchItem.title = "Remove from Login"
        } else {
            launchItem.title = "Start at Login"
        }
    }


}

