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
        //relationshipEmpCompany()
        getAllCompaniesRecord()
        getAllEmployees()
        
        deleteCompanyById(id: 3.0)
        //getCompanyById(byIdentifier: 1.0)
        //deleteAllCompany()
        //getAllCompaniesRecord()
        //deleteAllEmployees()
        getAllCompaniesRecord()
        getAllEmployees()
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
        let deleteEmp = getEmployeeById(byIdentifier: userId)
        
        guard deleteEmp != nil else{
            return false
        }
        
        PersistentStorage.shared.context.delete(deleteEmp!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    //Update Record
    func updateEmployeeRecords(userId: Float) -> Bool{
        let updateEmp = getEmployeeById(byIdentifier: userId)
        guard updateEmp != nil else{
            return false
        }
        
        updateEmp?.name = "New Name Updated"
        updateEmp?.address = "New address updated"
        
        PersistentStorage.shared.saveContext()
        return true
    }
    
   // getting Record
    func getEmployeeById(byIdentifier id: Float) -> Employee? {
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
    func getAllEmployees(){
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
    
    //delete all Employees
    
    func deleteAllEmployees(){
        let fetchCompany = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        let batchDelete = NSBatchDeleteRequest(fetchRequest: fetchCompany)
        
        do{
            try PersistentStorage.shared.context.execute(batchDelete)
            try PersistentStorage.shared.saveContext()
        }catch{
            print("Something Happened and program could not execute the command")
        }
    }
    
    
    //Company
    //Relationship between company and emloyee
    
    func relationshipEmpCompany(){
        
        //create a company
        let myCompany = Company(context: PersistentStorage.shared.context)
        
        myCompany.id = 3.0
        myCompany.companyName = "Amazon"
        
        //Create an Employee
        
        let myEmp = Employee(context: PersistentStorage.shared.context)
        myEmp.name = "First Amazon employee"
        myEmp.id = 3.0
        myEmp.address = "350 Amazon Forest lane"
        
        // Establishing a relationship
        myCompany.addToEmployee(myEmp)
        
        //Save the context
        PersistentStorage.shared.saveContext()
    }
    
    func getAllCompaniesRecord(){
        let coreDataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(coreDataPath[0])
        do{
            guard let results = try PersistentStorage.shared.context.fetch(Company.fetchRequest())
                    as? [Company] else {
                        return
                    }
           
            results.forEach({debugPrint($0.id, $0.companyName)})
        }
        catch{
            print(error)
        }
    }
    
    func getCompanyById(byIdentifier companyId: Float) -> Company? {
        let fetchCompany = NSFetchRequest<Company>( entityName: "Company")
        let compPredicate = NSPredicate(format: "id==%f", companyId as Float)
        fetchCompany.predicate = compPredicate
        do{
            
             let result = try? PersistentStorage.shared.context.fetch(fetchCompany).first
            guard result != nil else{
                return nil
            }
           // print(result?.companyName)
            return result
        }
        catch{
            print(error)
        }
        return nil
    }
    
    func deleteCompanyById(id: Float) -> Bool{
        let companyData = getCompanyById(byIdentifier: id)
        
        guard companyData != nil else{
            print("No company details was found")
            return false
        }
        
        PersistentStorage.shared.context.delete(companyData!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func deleteAllCompany(){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Company")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do{
            
            try PersistentStorage.shared.context.execute(request)
           try PersistentStorage.shared.saveContext()
        }catch{
            print("An error occurred")
        }
    }
}

