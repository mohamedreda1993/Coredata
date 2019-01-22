//
//  ViewController.swift
//  CoreDataPlease
//
//  Created by Mohamed reda on 8/14/18.
//  Copyright © 2018 fci. All rights reserved.
//
import UIKit
import CoreData   
    
    func insertNewProduct(){
        
        let products = NSEntityDescription.insertNewObject(forEntityName: "Products", into: context) as! Products
        
        let id:Int32! = Int32(productID.text!)
        let price:Double! = Double(productPrice.text!)
        
        products.productID = id ?? 0
        products.productName = productName.text ?? " "
        products.productPrice = price ?? 0.0
        
        do{
            
            context.insert(products as NSManagedObject)
            try context.save()
            print("insert Saved")
            
        }catch let error{
            print(error)
        }
        
    }
    
    func deleteAllProducts(){
        
        
        let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
        let deleteProducts = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context.execute(deleteProducts)
            try context.save()
        } catch let error {
            print(error)
        }
        
    }
    
    func deleteOneProduct(value:Int32){
        
        let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
        
        let predicate = NSPredicate(format: "productID='\(value)'")
        
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for restult in results{
                context.delete(restult)
            }
            
            //let oneResult = results.last // or first
            //context.delete(oneResult!)
            
            try context.save()
            
        } catch let error {
            print(error)
        }
        
    }
    
    
    func updateProducts(value:Int32){
        
        let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
        
        let predicate = NSPredicate(format: "productID='\(value)'")
        
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for restult in results{
                restult.productID = 10
                restult.productName = "Fawzy"
                restult.productPrice = 30.0
            }
            
            //let oneResult = results.last // or first
            //context.delete(oneResult!)
            
            try context.save()
            
        } catch let error {
            print(error)
        }
        
        
    }
    
    func selectProducts(){
        
        let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
        
        do {
            
            let results = try context.fetch(fetchRequest)
            
            for result in results{
                print(result.productID , " " ,result.productName! , " " ,result.productPrice)
            }
            
        } catch let error {
            print(error)
        }
        
    }
    
    
    func foundUpdateElseInsert(value:Int32){
        
        let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
        
        let predicate = NSPredicate(format: "productID='\(value)'")
        
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count != 0{
                
                for restult in results{
                    restult.productID = 10
                    restult.productName = "Fawzy"
                    restult.productPrice = 30.0
                }
                
                //let oneResult = results.last // or first
                //context.delete(oneResult!)
                
                try context.save()
            }else{
                
                let products = NSEntityDescription.insertNewObject(forEntityName: "Products", into: context) as! Products
                
                let id:Int32! = Int32(productID.text!)
                let price:Double! = Double(productPrice.text!)
                
                products.productID = id ?? 0
                products.productName = productName.text ?? " "
                products.productPrice = price ?? 0.0
                
                do{
                    
                    context.insert(products as NSManagedObject)
                    try context.save()
                    print("insert Saved")
                    
                }catch let error{
                    print(error)
                }
                
            }
            
            
            
        } catch let error {
            print(error)
        }
        
        
    }
    
    
    
    
    
    
}
