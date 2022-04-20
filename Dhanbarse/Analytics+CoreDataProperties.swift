//
//  Analytics+CoreDataProperties.swift
//  
//
//  Created by Goldmedal on 12/11/19.
//
//

import Foundation
import CoreData


extension Analytics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Analytics> {
        return NSFetchRequest<Analytics>(entityName: "Analytics")
    }

    @NSManaged public var screeName: String?
    @NSManaged public var screenId: Int16

}
