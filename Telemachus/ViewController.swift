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
        CommunicationTools.smsCommand(numberField.stringValue, messageField: messageField.stringValue)
        
    }

}

