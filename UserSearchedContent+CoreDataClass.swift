//
//  UserSearchedContent+CoreDataClass.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 23/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//
//

import Foundation
import CoreData

@objc(UserSearchedContent)
public class UserSearchedContent: NSManagedObject {

    convenience init(text: String, entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        self.init(entity: entity, insertInto: context)
        self.searchedKeyword = text
    }
    
}
