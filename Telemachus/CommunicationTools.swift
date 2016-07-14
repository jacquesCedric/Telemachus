//
//  CommunicationTools.swift
//  Telemachus
//
//  Created by Jacob Gaffney on 14/07/2016.
//  Licensed under the GPL v3
//

import Foundation

class CommunicationTools {
    class func smsCommand(numberTextField: String, messageTextField: String) {
        // Little bit of logging
        print("Attempting to send message")
        
        let number = validateNumber(numberTextField)
        let message = sanitizeMessage(messageTextField)
        
        // Setup our NSTask to use adb
        let task = NSTask()
        task.launchPath = "/usr/local/Cellar/android-platform-tools/23.0.1/bin/adb" // Should be smarter
        task.arguments = ["shell", "am", "startservice", "--user", "0", "-n", "com.android.shellms/.sendSMS", "-e", "contact", number, "-e", "msg", message]
        let pipe = NSPipe()
        task.standardOutput = pipe
        task.standardError = pipe
        
        print("Launching task")
        task.launch()
        task.waitUntilExit()
        print("Exiting task")
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