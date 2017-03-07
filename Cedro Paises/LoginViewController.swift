//
//  LoginViewController.swift
//  Cedro Paises
//
//  Created by Matheus Alves on 02/03/17.
//  Copyright © 2017 Matheus Alves. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import FacebookLogin
import FacebookCore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var btnLoginFacebook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLoginFacebook.addTarget(self,action: #selector(LoginViewController.loginButtonClickedd), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.activityIndicatorView.hidesWhenStopped = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func loginButtonClickedd() {
        self.activityIndicatorView.startAnimating()
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
                self.activityIndicatorView.stopAnimating()
            case .cancelled:
                print("Usuário cancelou o login.")
                self.activityIndicatorView.stopAnimating()
            case .success( _, _, _):
                let connection = GraphRequestConnection()
                connection.add(GraphRequest(graphPath: "/me", parameters: ["fields":"email,name"])) { httpResponse, result in
                    switch result {
                    case .success(let response):
                        let id = response.dictionaryValue?["id"]
                        let name = response.dictionaryValue?["name"]
                        let email = response.dictionaryValue?["email"]
                        let picUrl = "https://graph.facebook.com/\(id!)/picture?type=large"
                        let imgProfile = ImageUtils.getImageByUrl(url: picUrl)
                        
                        UserDefaults.standard.setValue(id, forKey: "user_id")
                        UserDefaults.standard.setValue(name, forKey: "user_name")
                        UserDefaults.standard.setValue(email, forKey: "user_email")
                        UserDefaults.standard.setValue(imgProfile, forKey: "user_image")
                        self.activityIndicatorView.stopAnimating()
                        if let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController {
                            self.present(tabBarController, animated: true, completion: nil)
                        }
                    case .failed(let error):
                        print("Falha na requisição: \(error)")
                        self.activityIndicatorView.stopAnimating()
                    }
                }
                connection.start()
                
            }
        }
    }

}
