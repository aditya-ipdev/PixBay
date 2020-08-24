//
//  UserSearchedContent+CoreDataProperties.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 23/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//
//

import Foundation
import CoreData


extension UserSearchedContent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSearchedContent> {
        return NSFetchRequest<UserSearchedContent>(entityName: "UserSearchedContent")
    }

    @NSManaged public var searchedKeyword: String?

}
