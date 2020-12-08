//
//  OperationFieldViewController.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 04/12/20.
//

import UIKit
import CloudKit

class OperationFieldViewController: UIViewController {
    
    //MARK: Passed Var
    
    var fName: CKRecord?
    
    
    //MARK: Connection
    
    @IBOutlet weak var fieldName: UILabel!
    
    @IBOutlet weak var operationName: UITextField!
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if fName == nil {
            fieldName.text = ""
        }else{
            fieldName.text = fName?.value(forKey: "fieldName") as? String
        }
        
        
      
    }

    
    //MARK: Database Call
    
    let dataBase = CKContainer.default().privateCloudDatabase
    
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let newRecord = CKRecord(recordType: fieldName.text!)
        
        if operationName.text?.isEmpty == true {
            saveBarButton.isEnabled = false
        }else{
            
            print(datePicker.date)
            
            newRecord.setValuesForKeys(["fieldOperation": String(operationName.text!), "date": datePicker.date])
            dataBase.save(newRecord) { (record, Error) in
                guard record != nil else {return}
                print("Saved Record!")
            }
            performSegue(withIdentifier: "Back", sender: self)
        }
    
    

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Back" {
            let backVC = segue.destination as! FieldDetailViewController
            backVC.fetchCludKITField = fName
        }
    }


}
