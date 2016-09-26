//
//  AppDelegate.swift
//  Telemachus
//
//  Created by Jacob Gaffney on 13/07/2016.
//  Licensed under the GPL v3
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    
    // Some functions to take care of menu items
    @IBAction func sendMessageMenuItem(sender: NSMenuItem) {
        
    }
    
    // This one's good to go though!
    @IBAction func viewOnGithub(sender: NSMenuItem) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://github.com/jacquesCedric/Telemachus")!)
    }
}

