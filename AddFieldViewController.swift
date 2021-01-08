//
//  AddFieldViewController.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 07/01/21.
//

import UIKit
import Firebase

class AddFieldViewController: UIViewController, UITextFieldDelegate {

    
    //MARK: Connection
    
    @IBOutlet weak var FieldName: RoundTextField!
    
    @IBOutlet weak var FieldArea: RoundTextField!
    
    @IBOutlet weak var saveButton: RoundButton!
    
    
    
    
    //MARK: Action
    
    @IBAction func saveButtonPressed(_ sender: RoundButton) {
        
        if FieldName.hasText == true {
        
            var ref: DocumentReference? = nil
            
            ref = db.collection("Field").addDocument(data: [
                "name": String(FieldName.text ?? "invalid name"),
                "area": String(FieldArea.text ?? "0")
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
            performSegue(withIdentifier: "ifNotNil", sender: nil)
        }else{
            saveButton.isEnabled = false
        }
        
        
    }
    
    
    //MARK: Firstore call
    
    let db = Firestore.firestore()
    
    //DoneButton
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light

        // Mark Keyboard ToolBar setting
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([doneButton], animated: false)
        
        FieldArea.inputAccessoryView = toolBar
        FieldArea.delegate = self
        
        FieldName.inputAccessoryView = toolBar
        FieldName.delegate = self
        
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ifNotNil" {
            let backVC = segue.destination as! FieldsViewController
            backVC.modalPresentationStyle = .fullScreen
        }
    }
    
    
    
    
    
}
