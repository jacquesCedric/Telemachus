//
//  CommunicationTools.swift
//  Telemachus
//
//  Created by Jacob Gaffney on 14/07/2016.
//  Copyright © 2016 Jacob Gaffney. All rights reserved.
//

import Foundation

class CommunicationTools {
    class func smsCommand(numberField: String, messageField: String) {
        // Little bit of logging
        print("Attempting to send message")
        //print("number is \(numberField) and message is \(messageField)")
        
        // Gotta wrap our message in quotes so it can be used as an argument
        let sentence = "\"" + messageField + "\""
        
        // Setup our NSTask to use adb
        let task = NSTask()
        task.launchPath = "/usr/local/Cellar/android-platform-tools/23.0.1/bin/adb" // Should be smarter
        task.arguments = ["shell", "am", "startservice", "--user", "0", "-n", "com.android.shellms/.sendSMS", "-e", "contact", numberField, "-e", "msg", sentence]
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        task.waitUntilExit()
    }

    
    
}