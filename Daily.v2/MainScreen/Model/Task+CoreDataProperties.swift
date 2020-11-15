//
//  Task+CoreDataProperties.swift
//  Daily.v2
//
//  Created by Бакулин Семен Александрович on 09.11.2020.
//  Copyright © 2020 Бакулин Семен Александрович. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var date: Date?
    @NSManaged public var isDone: Bool
    @NSManaged public var text: String?

}
