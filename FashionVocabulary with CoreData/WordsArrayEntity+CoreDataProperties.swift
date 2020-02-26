//
//  WordsArrayEntity+CoreDataProperties.swift
//  Fashion Vocabulary
//
//  Created by Batman on 2/18/20.
//  Copyright © 2020 Batman. All rights reserved.
//
//

import Foundation
import CoreData


extension WordsArrayEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordsArrayEntity> {
        return NSFetchRequest<WordsArrayEntity>(entityName: "WordsArrayEntity")
    }

    @NSManaged public var arrayName: String?
    @NSManaged public var wordEntities: NSSet?

}

// MARK: Generated accessors for wordEntities
extension WordsArrayEntity {

    @objc(addWordEntitiesObject:)
    @NSManaged public func addToWordEntities(_ value: WordEntity)

    @objc(removeWordEntitiesObject:)
    @NSManaged public func removeFromWordEntities(_ value: WordEntity)

    @objc(addWordEntities:)
    @NSManaged public func addToWordEntities(_ values: NSSet)

    @objc(removeWordEntities:)
    @NSManaged public func removeFromWordEntities(_ values: NSSet)

}
