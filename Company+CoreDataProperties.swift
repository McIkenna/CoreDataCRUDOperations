//
//  Company+CoreDataProperties.swift
//  CoreDataCRUDOperations
//
//  Created by New Account on 10/27/21.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var companyName: String?
    @NSManaged public var id: Float
    @NSManaged public var employee: NSSet?

}

// MARK: Generated accessors for employee
extension Company {

    @objc(addEmployeeObject:)
    @NSManaged public func addToEmployee(_ value: Employee)

    @objc(removeEmployeeObject:)
    @NSManaged public func removeFromEmployee(_ value: Employee)

    @objc(addEmployee:)
    @NSManaged public func addToEmployee(_ values: NSSet)

    @objc(removeEmployee:)
    @NSManaged public func removeFromEmployee(_ values: NSSet)

}

extension Company : Identifiable {

}
