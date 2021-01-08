//
//  FieldsViewController.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 06/01/21.
//

import UIKit
import Firebase

class FieldsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //MARK: Connection
    
    @IBOutlet weak var table: RoundTableView!
    
    
    //MARK: Action
    
    @IBAction func addFieldButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "addField", sender: self)
    }
    
    
    //MARK: Tableview Settings
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = FName[indexPath.row]
        
        return cell
    }
    
    
    
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchFirestoreData()
        
        table.delegate = self
        table.dataSource = self
    
        overrideUserInterfaceStyle = .light
        
    }

    //MARK: Query Firestore DB
    
    
    var FName = [String]()
    
    
    func fetchFirestoreData() {
        
        db.collection("Field").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data()["name"] ?? "")")
                    self.FName.append(document.data()["name"] as! String)
                    self.table.reloadData()
                }
                print(self.FName)
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addField" {
            let nextVC = segue.destination as! AddFieldViewController
        }
    }
    
    
}
