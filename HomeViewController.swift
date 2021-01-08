//
//  HomeViewController.swift
//  Farmer Journal
//
//  Created by Alberto Giambone on 06/01/21.
//

import UIKit
import Firebase
import FirebaseUI

class HomeViewController: UIViewController, FUIAuthDelegate {

    //MARK: Connection
    
    
    //MARK: Action
    
    @IBAction func LogOut(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
          } catch let err {
            print(err)
          }
    }
    
    @IBAction func FieldButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Field", sender: self)
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func showLoginVC() {
        let autUI = FUIAuth.defaultAuthUI()
        let providers = [FUIOAuth.appleAuthProvider()]
        
        autUI?.providers = providers
        
        let autViewController = autUI!.authViewController()
        autViewController.modalPresentationStyle = .fullScreen
        autViewController.overrideUserInterfaceStyle = .light
        self.present(autViewController, animated: true, completion: nil)
    }
    
    func showUserInfo(user:User) {
        
        print("USER.UID: \(user.uid)")
        UserDefaults.standard.setValue(user.uid, forKey: "userInfo")
    }

    override func viewWillAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.showUserInfo(user:user)
            } else {
                self.showLoginVC()
            }
        }
        overrideUserInterfaceStyle = .light
        
        
    }
    
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let user = authDataResult?.user {
            print("GREAT!!! You Are Logged in as \(user.uid)")
            UserDefaults.standard.setValue(user.uid, forKey: "userInfo")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Field" {
            let nextVC = segue.destination as! FieldsViewController
        }
    }
    
}
