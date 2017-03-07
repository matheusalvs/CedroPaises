//
//  ProfileViewController.swift
//  Cedro Paises
//
//  Created by Matheus Alves on 03/03/17.
//  Copyright © 2017 Matheus Alves. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.width / 2;
        self.imgProfile.clipsToBounds = true;
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.init(red: 47/255.0, green: 78/255.0, blue: 120/255.0, alpha: 1.0)
        
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        
        let id = UserDefaults.standard.value(forKey: "user_id")
        
        if (id == nil){
            if let loginViewController = (self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController"))! as? UIViewController {
                self.present(loginViewController, animated: true, completion: nil)
            }
        }
        
        if UserDefaults.standard.value(forKey: "user_image") != nil {
            let pic = ImageUtils.getImageByBase64(strBase64: (UserDefaults.standard.value(forKey: "user_image") as? String)!)
            imgProfile.image = pic as? UIImage;
        }
    }
    
}
