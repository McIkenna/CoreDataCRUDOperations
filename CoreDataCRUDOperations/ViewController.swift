//
//  ViewController.swift
//  CoreDataCRUDOperations
//
//  Created by New Account on 10/27/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //createEmployee()
       /*if(updateEmployeeRecords(userId: 2.0)){
            print("Record Updated")
        }*/
       // deleteEmployeeRecord(userId: 2.0)
       // fetchEmployeeRecords()
        relationshipEmpCompany()
    }

    //Post Employee - create
    func createEmployee(){
        let employee = Employee(context: PersistentStorage.shared.context)
        
        employee.name = "Employee - 3"
        employee.address = "5740 blue rd Rd"
        employee.id = 2.0
        
        PersistentStorage.shared.saveContext()
    }
    
    //Delete Record By Id
    func deleteEmployeeRecord(userId: Float) -> Bool{
        let deleteEmp = getEmployees(byIdentifier: userId)
        
        guard deleteEmp != nil else{
            return false
        }
        
        PersistentStorage.shared.context.delete(deleteEmp!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    //Update Record
    func updateEmployeeRecords(userId: Float) -> Bool{
        let updateEmp = getEmployees(byIdentifier: userId)
        guard updateEmp != nil else{
            return false
        }
        
        updateEmp?.name = "New Name Updated"
        updateEmp?.address = "New address updated"
        
        PersistentStorage.shared.saveContext()
        return true
    }
    
   // getting Record
    func getEmployees(byIdentifier id: Float) -> Employee? {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        let predicate = NSPredicate(format: "id==%f", id as Float)
        
        fetchRequest.predicate = predicate
        do{
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else{
                return nil
            }
            return result
        }
        catch{
            print(error)
        }
        
        return nil
    }
    
    //Get all Employees
    func fetchEmployeeRecords(){
        let coreDataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(coreDataPath[0])
        do{
            guard let results = try PersistentStorage.shared.context.fetch(Employee.fetchRequest())
                    as? [Employee] else {
                        return
                    }
            results.forEach({debugPrint($0.name, $0.address)})
        }
        catch{
            print(error)
        }
    }
    
    //Relationship between company and emloyee
    
    func relationshipEmpCompany(){
        
        //create a company
        
        let myCompany = Company(context: PersistentStorage.shared.context)
        
        myCompany.companyName = "Google"
        
        //Create an Employee
        
        let myEmp = Employee(context: PersistentStorage.shared.context)
        myEmp.name = "New Apple Employee"
        myEmp.id = 100.0
        myEmp.address = "MyHome address"
        
        // Establishing a relationship
        myCompany.addToEmployee(myEmp)
        
        //Save the context
        PersistentStorage.shared.saveContext()
    }
}

