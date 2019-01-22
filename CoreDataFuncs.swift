//
//  insertVlueOrUpdate.swift
//  HirajSana
//
//  Created by Mohamed reda on 6/28/18.
//  Copyright © 2018 fci. All rights reserved.
//
import UIKit
import CoreData

public func insertOrUpdateValueWithKey(Pname:String ,Pimage:String ,Pprice:Float ,Pcount:Int ,PTprice:Float , Pdescripe:String , Prate:Float){
    
    let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
    
    
    //we check if product id exist before dont insert it just update data
    let predicate = NSPredicate(format: "productName='\(Pname)'")
    fetchRequest.predicate = predicate
    
    do {
        let results = try context.fetch(fetchRequest)
        print(results.count)
        if(results.count != 0){
            print("existsssssssssss")
            
            for result in results{
                result.productName = Pname
                result.productCount = Int16(Pcount)
                result.productImage = Pimage
                result.productPrice = Pprice
                result.productTprice = PTprice
                result.productDescription = Pdescripe
                result.productRate = Prate
            }
            
            
            
            do {
                try context.save()
            } catch let error as NSError {
                print ("Error first demande insertion \(error)")
            }
            
        }//Insert Code
        else if (results.count == 0) {
            
            let Products = NSEntityDescription.insertNewObject(forEntityName: "Products", into: context) as! Products
            
            result.productName = Pname
            result.productCount = Int16(Pcount)
            result.productImage = Pimage
            result.productPrice = Pprice
            result.productTprice = PTprice
            result.productDescription = Pdescripe
            result.productRate = Prate
            
            
            print("Not existsssssssssss")
            context.insert(Products)
            
            do {
                try context.save()
            } catch let error as NSError {
                print ("Error first demande insertion \(error)")
            }
        }
        
        
    } catch {
        let fetchError = error as NSError
        print(fetchError)
    }
    
}


public func updateOneKey(Pname:String ,Pcount:Int ,PTprice:Float){
    
    let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
    
    //we check if product id exist before dont insert it just update data
    let predicate = NSPredicate(format: "productName='\(Pname)'")
    fetchRequest.predicate = predicate
    
    do {
        let results = try context.fetch(fetchRequest)
        print(results.count)
        print("existsssssssssss")
        if(results.count != 0){
            print("existsssssssssss")
            
            for result in results{
                result.productName = Pname
                result.productCount = Int16(Pcount)
                result.productTprice = PTprice
            }
            
            
            do {
                try context.save()
            } catch let error as NSError {
                print ("Error first demande insertion \(error)")
            }
            
        }
    } catch {
        let fetchError = error as NSError
        print(fetchError)
    }
    
}



public func DeleteOneKey(Pname:String){
    
    let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
    
    let predicate = NSPredicate(format: "productName='\(Pname)'")
    fetchRequest.predicate = predicate
    
    if let result = try? context.fetch(fetchRequest) {
        for object in result {
            context.delete(object as NSManagedObject)
        }
    }
    
    do {
        try context.save()
    }catch let error as NSError {
        print ("Error first demande insertion \(error)")
    }
    
}


func deleteAllData(){
    
    //let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")
    let deleteFetch : NSFetchRequest<Products> = Products.fetchRequest()
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch as! NSFetchRequest<NSFetchRequestResult>)
    
    do {
        try context.execute(deleteRequest)
        try context.save()
    } catch {
        print ("There was an error")
    }
}
