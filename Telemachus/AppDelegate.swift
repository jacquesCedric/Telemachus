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
    // Not yet implemented because I don't quite understand some components
    @IBAction func clearFieldsMenuItem(sender: NSMenuItem) {
        
    }
    
    @IBAction func sendMessageMenuItem(sender: NSMenuItem) {
        
    }
    
    // This one's good to go though!
    @IBAction func viewOnGithub(sender: NSMenuItem) {
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://github.com/jacquesCedric/Telemachus")!)
    }
}

