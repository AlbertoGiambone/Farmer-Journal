//
//  AreaUnitViewController.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 08/01/21.
//

import UIKit
import Firebase

class AreaUnitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: areaUnit array
    
    var agriUnit: [(name: String, value: String)] = [("Acre", "4046.86"), ("Hectare", "10000"), ("Rood", "1011.714"), ("Square Meters", "1.0"), ("Square Yarde", "0.8361274"), ("Square Feet", "0.09290304"), ("Square Inch", "0.00064516"), ("Square Rod", "25.2929"), ("Square Mile", "2589988.0")]
    
    //Array unità prodotto
    let measureUnit: [(misura: String, attributo: String)] = [("L", "1.00"), ("cl", "0.01"),("ml", "0.001"), ("Kg", "1.00"), ("Hg", "0.1"), ("g", "0.001")]
    
    
    //MARK: passed var
    
    var areaViewController: Bool?
    
    var seasonViewController: Bool?
    
    
    
    //MARK: Connection
    
    @IBOutlet weak var customAreaName: RoundTextField!
    
    @IBOutlet weak var customAreaMeters: RoundTextField!
    
    @IBOutlet weak var addButton: RoundButton!
    
    @IBOutlet weak var table: RoundTableView!
    
    
    
    
    //MARK: action
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()



    }
    
    
    //MARK: tableview Settings
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
