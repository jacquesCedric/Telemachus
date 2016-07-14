//
//  ViewController.swift
//  Telemachus
//
//  Created by Jacob Gaffney on 13/07/2016.
//  Licensed under the GPL v3
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var numberField: NSTextField!
    @IBOutlet var messageField: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    @IBAction func sendMessage(sender: AnyObject) {
        // Little bit of logging
        print("Attempting to send message")
        print("number is \(numberField.stringValue) and message is \(messageField.stringValue)")
        
        // Gotta wrap our message in quotes so it can be used as an argument
        let sentence = "\"" + messageField.stringValue + "\""
        
        // Setup our NSTask to use adb
        let task = NSTask()
        task.launchPath = "/usr/local/Cellar/android-platform-tools/23.0.1/bin/adb" // Should be smarter
        task.arguments = ["shell", "am", "startservice", "--user", "0", "-n", "com.android.shellms/.sendSMS", "-e", "contact", numberField.stringValue, "-e", "msg", sentence]
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        task.waitUntilExit()
        
    }

}

