//
//  ProfileTableViewController.swift
//  Cedro Paises
//
//  Created by Matheus Alves on 05/03/17.
//  Copyright © 2017 Matheus Alves. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblName.text = UserDefaults.standard.value(forKey: "user_name") as! String?
        lblEmail.text = UserDefaults.standard.value(forKey: "user_email") as! String?
    }

    @IBAction func btnLogoutOnClick(_ sender: UIButton) {
        UserDefaults.standard.setValue(nil, forKeyPath: "user_id")
        UserDefaults.standard.setValue(nil, forKeyPath: "user_name")
        UserDefaults.standard.setValue(nil, forKeyPath: "user_email")
        
        if let loginViewController = (self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController"))! as? UIViewController {
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    

}
