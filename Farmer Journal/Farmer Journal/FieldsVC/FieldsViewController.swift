//
//  FieldsViewController.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 22/11/20.
//

import UIKit
import CloudKit

class FieldsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Connection
    
    @IBOutlet weak var fieldTable: UITableView!
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FieldList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fieldTable.dequeueReusableCell(withIdentifier: "cell")
        
        let surface = FieldList[indexPath.row].value(forKey: "fieldArea")
        let name = FieldList[indexPath.row].value(forKey: "fieldName")
        cell?.textLabel!.text = String("\(name!)")
        cell?.detailTextLabel!.text = String("\(surface!) \(defFieldUnit!)")
        return cell!
    }
    
    
    var recordSelected: CKRecord?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recordSelected = FieldList[indexPath.row]
        performSegue(withIdentifier: "fielDetail", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        
            let removed = FieldList.remove(at: indexPath.row)
            self.fieldTable.deleteRows(at: [indexPath], with: .fade)
            let uuu = CKModifyRecordsOperation.init(recordIDsToDelete: [removed.recordID])
            CKContainer.default().privateCloudDatabase.add(uuu)
        }
    }
    
    let dataBase = CKContainer.default().privateCloudDatabase
    
    var FieldList = [CKRecord]()
    
    func queryDatabase() {
        let query = CKQuery(recordType: "FieldList", predicate: NSPredicate(value: true))
        dataBase.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else {return}
            self.FieldList = records
            DispatchQueue.main.async {
                self.fieldTable.reloadData()
            }
        }
    }
    
    
    var defFieldUnit: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        queryDatabase()
        
        //MARK: TableView data
        
        fieldTable.delegate = self
        fieldTable.dataSource = self
        
        
        defFieldUnit = UserDefaults.standard.object(forKey: "UnitName") as? String
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        queryDatabase()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "fielDetail" {
        let nextVC = segue.destination as! FieldDetailViewController
            nextVC.modalPresentationStyle = .fullScreen
            
            nextVC.fetchCludKITField = recordSelected
        }
    }
    
    
}
