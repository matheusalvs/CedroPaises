//
//  CountryViewController.swift
//  Cedro Paises
//
//  Created by Matheus Alves on 06/03/17.
//  Copyright © 2017 Matheus Alves. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    var country = Country()
    var countryTableViewController: CountryTableViewController!
    
    @IBAction func btnCloseOnClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnSaveOnClick(_ sender: UIBarButtonItem) {
        countryTableViewController.save()
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.topItem?.title = self.country.shortName
        if country.image != "" {
            countryImage.image = ImageUtils.getImageByBase64(strBase64: country.image)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "countryDetails" {
            self.countryTableViewController = segue.destination as! CountryTableViewController
            self.countryTableViewController.country = self.country
        }
    }

}
