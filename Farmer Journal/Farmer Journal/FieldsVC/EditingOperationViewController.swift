//
//  EditingOperationViewController.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 07/12/20.
//

import UIKit
import CloudKit

class EditingOperationViewController: UIViewController {

    
    //MARK: Passing CloudKIT object
    
    var fetchCludKITOperation: CKRecord?
    var NF: String?
    
    //MARK: Connection
    
    @IBOutlet weak var OpName: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    //MARK: QueryDB
    
    let dataBase = CKContainer.default().privateCloudDatabase
    
    var OperationList = [CKRecord]()
    
    func queryDatabase() {
        let query = CKQuery(recordType: NF ?? "", predicate: NSPredicate(value: true))
        dataBase.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else {return}
            self.OperationList = records
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        queryDatabase()
    }
    
    @IBAction func saveB(_ sender: UIBarButtonItem) {
        
        if OpName.text?.isEmpty == true {
            saveButton.isEnabled = false
        }else{
            
        }
        
    }
    
}
