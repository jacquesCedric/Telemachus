//
//  CommunicationTools.swift
//  Telemachus
//
//  Created by Jacob Gaffney on 14/07/2016.
//  Licensed under the GPL v3
//

import Foundation

class CommunicationTools {
    class func smsCommand(numberField: String, messageField: String) {
        // Little bit of logging
        print("Attempting to send message")
        
        let number = validateNumber(numberField)
        let message = sanitizeMessage(messageField)
        
        // Setup our NSTask to use adb
        let task = NSTask()
        task.launchPath = "/usr/local/Cellar/android-platform-tools/23.0.1/bin/adb" // Should be smarter
        task.arguments = ["shell", "am", "startservice", "--user", "0", "-n", "com.android.shellms/.sendSMS", "-e", "contact", number, "-e", "msg", message]
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        task.waitUntilExit()
    }

    static func validateNumber(numberField: String) -> String {
        
        return numberField
    }
    
    static func sanitizeMessage(messageField: String) -> String {
        let modifiedString = messageField.stringByReplacingOccurrencesOfString("\"", withString: "\\\"")
        
        // Gotta wrap our message in quotes so it can be used as an argument
        return "\"" + modifiedString + "\""
    }
    
}