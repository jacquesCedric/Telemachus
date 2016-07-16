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
    @IBOutlet var messageField: NSTextField!
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
        messageField.placeholderString = "Write a Message..."
        
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
        CommunicationTools.smsCommand(numberField.stringValue, messageTextField: messageField.stringValue)
        
        // Clean up the form
        print("clearing inputs")
        clearFields()
    }
    
    
    // Assign contacts number to number field
    func tableViewClick(sender: AnyObject) {
        let item = sortContacts(returnContacts())[tableView.selectedRow].1
        numberField.stringValue = item
    }
    
    // Returns a dictionary of relevant contacts RETURNS AS DICTIONARY
    func returnContacts() -> [String: String] {
        // This will be our dictionary for names and numbers
        var namesAndNumbers = [String: String]()
        
        // This block makes sure we only collect mobile numbers for our list
        for contact in contacts{
            if contact.phoneNumbers.first?.value != nil {
                let phoneNumber = CommunicationTools.validateNumber((contact.phoneNumbers.first?.value as? CNPhoneNumber)!.stringValue)
                let fullname = CNContactFormatter.stringFromContact(contact, style: .FullName)
                
                // Only mobile numbers, thanks!
                if phoneNumber.characters.count > 8{
                    namesAndNumbers[fullname!] = phoneNumber
                }
            }
        }
        
        return namesAndNumbers
    }
    
    // Capable of sorting our contacts alphabetically RETURNS AS ARRAY
    func sortContacts(namesAndNumbers: [String: String]) -> [(String, String)]{
        // Create a dictionary that's sorted alphabetically by key and includes values
        let sortedStrings = namesAndNumbers.sort { $0.0 < $1.0}
        return sortedStrings
    }
    
    
    // Let's collect our contacts from different containers
    lazy var contacts: [CNContact] = {
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
            CNContactPhoneNumbersKey]
        
        // Collect all containers, in the event user has more than one
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containersMatchingPredicate(nil)
        } catch {
            print("Error fetching containers")
        }
        
        // Collect all the contacts from each of these containers
        var results: [CNContact] = []
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainerWithIdentifier(container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContactsMatchingPredicate(fetchPredicate, keysToFetch: keysToFetch)
                
                // Collect the contact information we need
                results.appendContentsOf(containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        // This value should be all of our contacts, albeit unformatted and full of extra stuff
        return results
    }()
    
    
    // Clean up fields
    func clearFields() {
        numberField.stringValue = ""
        messageField.stringValue = ""
    }
}


// This determines how many rows, and it works
extension ViewController : NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return sortContacts(returnContacts()).count ?? 0
    }
}

// This is meant to determine what's in the cells, and it does not work
extension ViewController : NSTableViewDelegate {
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text:String = ""
        var cellIdentifier: String = ""
        
        // Grab our details
        let item = sortContacts(returnContacts())[row]
        
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

