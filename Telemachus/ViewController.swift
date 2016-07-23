//
//  ViewController.swift
//  Telemachus
//
//  Created by Jacob Gaffney on 13/07/2016.
//  Licensed under the GPL v3
//

import Cocoa
import Contacts

class ViewController: NSViewController {

    @IBOutlet var numberField: NSTextField!
    @IBOutlet var messageField: NSTextView!
    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sort out the table
        tableView.setDelegate(self)
        tableView.setDataSource(self)
        tableView.target = self
        tableView.action = #selector(ViewController.tableViewClick(_:))
        
        // Set row height
        self.tableView.rowHeight = 34.0
        
        // Make sure our textfields' purpose is clear to the user
        numberField.placeholderString = "Phone Number"
        //messageField.placeholderString = "Write a Message..."
        messageField.font = NSFont(name: "Helvetica Neue", size: 13)
        
        //let example = sortContacts(returnContacts())
        tableView.reloadData()
    }
    
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // What happens when you click the send button
    @IBAction func sendMessage(sender: NSButton) {
        // Send our SMS
        CommunicationTools.smsCommand(numberField.stringValue, messageTextField: (messageField.textStorage as NSAttributedString!).string)
        
        // Clean up the form
        print("clearing inputs")
        clearFields()
    }
    
    
    // Assign contacts number to number field
    func tableViewSelectionDidChange(notification: NSNotification) {
        let item = ContactTools().sortContacts(ContactTools().returnContacts())[tableView.selectedRow].1
        numberField.stringValue = item
    }
    
    func tableViewClick(sender: AnyObject) {
        let item = ContactTools().sortContacts(ContactTools().returnContacts())[tableView.selectedRow].1
        numberField.stringValue = item
    }
    
    // Clean up fields
    func clearFields() {
        numberField.stringValue = ""
        messageField.textStorage!.mutableString.setString("")
    }
}


// This determines how many rows, and it works
extension ViewController : NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return ContactTools().sortContacts(ContactTools().returnContacts()).count ?? 0
    }
}

// This is meant to determine what's in the cells, and it does not work
extension ViewController : NSTableViewDelegate {
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text:String = ""
        var cellIdentifier: String = ""
        
        // Grab our details
        let item = ContactTools().sortContacts(ContactTools().returnContacts())[row]
        
        // Grab our contact names
        if tableColumn == tableView.tableColumns[0] {
            text = item.0
            cellIdentifier = "NameCellID"
        }
        if tableColumn == tableView.tableColumns[1] {
            text = item.1
            cellIdentifier = "NumberCellID"
        }
        
        // Create our cell view
        if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        
        return nil
    }
}

