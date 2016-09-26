//
//  ContactTools.swift
//  Telemachus
//
//  Created by Jacob Gaffney on 23/07/2016.
//  Copyright © 2016 Jacob Gaffney. All rights reserved.
//

import Foundation
import Contacts

class ContactTools {
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
    
}