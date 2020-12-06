//
//  FieldDetailViewController.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 01/12/20.
//

import UIKit
import CloudKit

class FieldDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Passing CloudKIT object
    
    var fetchCludKITField: CKRecord?
    
    //MARK: Connection
    
    @IBOutlet weak var fieldName: UILabel!
    
    @IBOutlet weak var seasonGrow: UILabel!
    
    @IBOutlet weak var operationTable: UITableView!
    
    
    //MARK: Tableview Settings
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FieldList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = operationTable.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = FieldList[indexPath.row].value(forKey: "fieldOperation") as? String
        cell?.detailTextLabel?.text = FieldList[indexPath.row].value(forKey: "date") as? String
        
        return cell!
        
    }
    
    //MARK: QueryDB
    
    let dataBase = CKContainer.default().privateCloudDatabase
    
    var FieldList = [CKRecord]()
    
    func queryDatabase() {
        let query = CKQuery(recordType: NF!, predicate: NSPredicate(value: true))
        dataBase.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else {return}
            self.FieldList = records
            DispatchQueue.main.async {
                self.operationTable.reloadData()
            }
        }
    }
    
    var NF: String?
    
    override func viewWillAppear(_ animated: Bool) {
        NF = fetchCludKITField?.value(forKey: "fieldName") as? String
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        operationTable.delegate = self
        operationTable.dataSource = self
        
        fieldName.text = fetchCludKITField?.value(forKey: "fieldName") as? String
        
        
        //print(fetchCludKITField!)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "addOp" {
        let nextVC = segue.destination as! OperationFieldViewController
        nextVC.fName = fetchCludKITField
        }
    }
   

}
