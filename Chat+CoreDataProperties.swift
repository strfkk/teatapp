//
//  Chat+CoreDataProperties.swift
//  teatApp
//
//  Created by streifik on 13.12.2022.
//
//

import Foundation
import CoreData


extension Chat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chat> {
        return NSFetchRequest<Chat>(entityName: "Chat")
    }

    @NSManaged public var userName: String?
    @NSManaged public var userEmail: String?
    @NSManaged public var messages: Set<Message1>
    @NSManaged public var user: User?
   // @NSManaged public var userEmails: [String]
    @NSManaged public var chatEmails: Set<ChatEmail>
}

// MARK: Generated accessors for messages
extension Chat {

//    @objc(addMessagesObject:)
//    @NSManaged public func addToMessages(_ value: Message1)
//
//    @objc(removeMessagesObject:)
//    @NSManaged public func removeFromMessages(_ value: Message1)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: NSSet )

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: NSSet)

}

extension Chat : Identifiable {

}
