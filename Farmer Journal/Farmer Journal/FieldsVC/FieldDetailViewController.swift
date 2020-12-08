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
        return OperationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = operationTable.dequeueReusableCell(withIdentifier: "cell")
        
        let op = OperationList[indexPath.row].value(forKey: "fieldOperation") as? String
        cell?.textLabel?.text = String(op ?? "no Op. Name")
        
        //MARK: Working with -> NSDate
        
        let opd = OperationList[indexPath.row].value(forKey: "date")
        
        let calendar = Calendar.current
        _ = DateComponents(calendar: calendar, year: 2000, month: 01, day: 01)
        let Dday = calendar.dateComponents([.day], from: opd as! Date )
        let Mmonth = calendar.dateComponents([.month], from: opd as! Date )
        let Yyear = calendar.dateComponents([.year], from: opd as! Date )
        
        let opDate = String("\(Dday.day!)-\(Mmonth.month!)-\(Yyear.year!)")
        
        cell?.detailTextLabel?.text = String(opDate)
        print(OperationList[indexPath.row].value(forKey: "fieldOperation") as? String ?? "no value")
        print(OperationList[indexPath.row].value(forKey: "date") as? String ?? "no date")
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    var recordSelected: CKRecord?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recordSelected = OperationList[indexPath.row]
        
        performSegue(withIdentifier: "editOP", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removed = OperationList.remove(at: indexPath.row)
            self.operationTable.deleteRows(at: [indexPath], with: .fade)
            let uuu = CKModifyRecordsOperation.init(recordIDsToDelete: [removed.recordID])
            CKContainer.default().privateCloudDatabase.add(uuu)
        }
    }
    
    
    //MARK: QueryDB
    
    let dataBase = CKContainer.default().privateCloudDatabase
    
    var OperationList = [CKRecord]()
    
    func queryDatabase() {
        let query = CKQuery(recordType: NF ?? "", predicate: NSPredicate(value: true))
        dataBase.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else {return}
            self.OperationList = records
            DispatchQueue.main.async {
                self.operationTable.reloadData()
            }
        }
    }
    
    var NF: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NF = fetchCludKITField?.value(forKey: "fieldName") as? String
        
        operationTable.delegate = self
        operationTable.dataSource = self
        
        fieldName.text = NF
                
        queryDatabase()
        //print(fetchCludKITField!)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "addOp" {
        let nextVC = segue.destination as! OperationFieldViewController
        nextVC.fName = fetchCludKITField
        }
        if segue.identifier == "editOP" {
            let editOpVC = segue.destination as! EditingOperationViewController
            editOpVC.fetchCludKITOperation = recordSelected
            editOpVC.NF = NF
        }
    }
   

}
