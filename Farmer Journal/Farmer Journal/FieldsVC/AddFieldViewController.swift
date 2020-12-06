//
//  AddFieldViewController.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 22/11/20.
//

import UIKit
import CloudKit

class AddFieldViewController: UIViewController {

    
    //MARK: Connection
    
    @IBOutlet weak var fieldName: UITextField!
    
    @IBOutlet weak var fieldArea: UITextField!
    
    @IBOutlet weak var Sbutton: UIBarButtonItem!
    
    
    let dataBase = CKContainer.default().privateCloudDatabase
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
    }
    

    @IBAction func SaveField(_ sender: UIBarButtonItem) {
        
        let newRecord = CKRecord(recordType: "FieldList")
        
        if ((fieldName.text?.isEmpty) != false) {
            Sbutton.isEnabled = false
        }else{
            newRecord.setValuesForKeys(["fieldName": String(fieldName.text!), "fieldArea": Double(fieldArea.text ?? "0")!])
            dataBase.save(newRecord) { (record, Error) in
                guard record != nil else {return}
                print("Saved Record!")
                
            }
            
        }
        performSegue(withIdentifier: "backHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "backHome" {
        let returnVC = segue.destination as! FieldsViewController
        returnVC.modalPresentationStyle = .fullScreen
        }
    }
    
    
}
