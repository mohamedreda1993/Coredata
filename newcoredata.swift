//
//  ViewController.swift
//  CoreData3-10
//
//  Created by Mohamed reda on 11/4/18.
//  Copyright © 2018 fci. All rights reserved.
//
import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var countTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.integer(forKey: "id") == 0{
            UserDefaults.standard.set(1, forKey: "id")
        }
    }
    
    
    @IBAction func selectP(_ sender: Any) {
        
        let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
        
        do{
            
           let results = try contex.fetch(fetchRequest)
            
            for result in results{
                print(result.pID , " " ,result.pName as! String , " " ,result.pPrice, " " ,result.pCount)
            }
            
        }catch{
            
        }
        
    }
    
    
    @IBAction func insertP(_ sender: Any) {
        
        //
        
        let product = NSEntityDescription.insertNewObject(forEntityName: "Products", into: contex) as! Products
        
        product.pID = Int64(UserDefaults.standard.integer(forKey: "id"))
        product.pName = nameTF.text!
        product.pPrice = Double(priceTF.text!)!
        product.pCount = Int64(countTF.text!)!

        do{
            contex.insert(product)
            try contex.save()
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "id") + 1, forKey: "id")
            
            print("data inserted")
        }catch{
            
        }
        
        
    }
    
    
    @IBAction func updateP(_ sender: Any) {
        
        let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
        let predicate = NSPredicate(format: "pID='\(Int64(idTF.text!)!)'")
        
        fetchRequest.predicate = predicate
        do{
            
            let results = try contex.fetch(fetchRequest)
            
            //results.first
            
            //var i:Int64 = 1
            
            for result in results{
                
                /*result.pID = i
                i += 1*/
                
                result.pName = nameTF.text!
                result.pPrice = Double(priceTF.text!)!
                result.pCount = Int64(countTF.text!)!
                
            }
            
            try contex.save()
            
            
        }catch{
            
        }
        
    }
    
    
    @IBAction func deleteP(_ sender: Any) {
        
        let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
        
        let predicate = NSPredicate(format: "pID='\(Int64(idTF.text!)!)'")
        
        fetchRequest.predicate = predicate
        
        do{
            
            let results =  try contex.fetch(fetchRequest)
            
            for result in results{
                contex.delete(result)
            }

            try contex.save()
            
        }catch{
            
        }

    }
    
    
    @IBAction func deleteAP(_ sender: Any) {
        UserDefaults.standard.set(0, forKey: "id")
        
        let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
        
        do{
            
            let results =  try contex.fetch(fetchRequest)
            
            for result in results{
                contex.delete(result)
            }
            
            try contex.save()
            
        }catch{
            
        }
        
        
    }
    
    
    


}
