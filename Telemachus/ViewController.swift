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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numberField.placeholderString = "Phone Number"
        messageField.placeholderString = "Write a message"
        
        for contact in contacts{
            print("\((contact.phoneNumbers.first?.value as? CNPhoneNumber)?.stringValue) - \(contact.givenName)")
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    // What happens when you click the send button
    @IBAction func sendMessage(sender: NSButton) {
        CommunicationTools.smsCommand(numberField.stringValue, messageTextField: messageField.stringValue)
        
        print("clearing inputs")
        clearFields()
    }

    func clearFields() {
        numberField.stringValue = ""
        messageField.stringValue = ""
    }
    
    
    // Let's collect our contacts from different containers
    lazy var contacts: [CNContact] = {
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
            CNContactPhoneNumbersKey]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containersMatchingPredicate(nil)
        } catch {
            print("Error fetching containers")
        }
        
        var results: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainerWithIdentifier(container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContactsMatchingPredicate(fetchPredicate, keysToFetch: keysToFetch)
                results.appendContentsOf(containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        
        return results
        
    }()
    
}

