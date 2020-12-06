//
//  SettingUnitViewController.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 01/12/20.
//

import UIKit
import CloudKit

class SettingUnitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Array of unit
    var fieldUnit: [(unitName: String, unitValue: String)] = [("Acre", "4046.86"), ("Hectare", "10000"), ("Rood", "1011.714"), ("Square Meters", "1.0"), ("Square Yarde", "0.8361274"), ("Square Feet", "0.09290304"), ("Square Inch", "0.00064516"), ("Square Rod", "25.2929"), ("Square Mile", "2589988.0")]
    
    
    
    //MARK: Connection

    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var defaultUnitLabel: UILabel!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fieldUnit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = fieldUnit[indexPath.row].unitName
        cell?.textLabel!.font = UIFont(name: "Galvji", size: 15)
        cell?.detailTextLabel?.text = String("\(fieldUnit[indexPath.row].unitValue) Square meters")
        cell?.detailTextLabel?.font = UIFont(name: "Galvji", size: 9)
        
        return cell!
    }
    
    var selectedUnitname: String?
    var selectedUnitValue: String?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        table.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedUnitname = fieldUnit[indexPath.row].unitName
        selectedUnitValue = fieldUnit[indexPath.row].unitValue
        
        UserDefaults.standard.setValue(selectedUnitname, forKey: "UnitName")
        UserDefaults.standard.setValue(selectedUnitValue, forKey: "UnitValue")
        
        defaultUnitLabel.text = UserDefaults.standard.object(forKey: "UnitName") as? String ?? ""
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        table.cellForRow(at: indexPath)?.accessoryType = .none
        UserDefaults.standard.removeObject(forKey: "UnitName")
        UserDefaults.standard.removeObject(forKey: "UnitValue")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
    
        
        if UserDefaults.standard.object(forKey: "UnitName") == nil {
            defaultUnitLabel.text = "set the unit value"
        }else{
            var uuuu = UserDefaults.standard.object(forKey: "UnitName")
        defaultUnitLabel.text = String("\(uuuu!)")
        }
    }
    


}
