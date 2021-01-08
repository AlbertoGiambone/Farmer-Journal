//
//  SettingsViewController.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 06/01/21.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Connection
    
    @IBOutlet weak var unitTable: UITableView!
    
    @IBOutlet weak var seasonTable: UITableView!
    
    
    //MARK: Action
    
    
    
    
    
    //MARK: tableview Settings
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == unitTable {
        
        let cell = unitTable.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = String("Default Unit Ha")
        cell?.detailTextLabel?.text = String("Ha = 10000 square meters")
            
            return cell!
        }else{
            
            let cell = unitTable.dequeueReusableCell(withIdentifier: "sesonCell")
            cell?.textLabel?.text = String("Current Season")
            cell?.detailTextLabel?.text = String("2020 - 2021")
                
                return cell!
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == unitTable {
            performSegue(withIdentifier: "unitSegue", sender: self)
        }else{
            performSegue(withIdentifier: "seasonSegue", sender: self)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        
        
        unitTable.delegate = self
        unitTable.dataSource = self
    }
    

    //MARK: segue customization
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unitSegue" {
            
            let areaVC = segue.destination as! AreaUnitViewController
            areaVC.areaViewController = true
        }
        if segue.identifier == "seasonSegue" {
            
            let seasonVC = segue.destination as! AreaUnitViewController
            seasonVC.seasonViewController = true
        }
        
    }
  

}
