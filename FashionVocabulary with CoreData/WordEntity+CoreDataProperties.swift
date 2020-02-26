//
//  WordEntity+CoreDataProperties.swift
//  Fashion Vocabulary
//
//  Created by Batman on 2/18/20.
//  Copyright © 2020 Batman. All rights reserved.
//
//

import Foundation
import CoreData


extension WordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordEntity> {
        return NSFetchRequest<WordEntity>(entityName: "WordEntity")
    }

    @NSManaged public var belarusianDefinition: String?
    @NSManaged public var belarusianWord: String?
    @NSManaged public var englishDefinition: String?
    @NSManaged public var englishWord: String?
    @NSManaged public var wordImage: Data?
    @NSManaged public var wordArrayEntity: WordsArrayEntity?

}
