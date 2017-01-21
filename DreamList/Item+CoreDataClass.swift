//
//  Item+CoreDataClass.swift
//  DreamList
//
//  Created by Dmytro Aprelenko on 22.01.17.
//  Copyright © 2017 Dmytro Aprelenko. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }

}
