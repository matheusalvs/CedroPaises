//
//  CountriesViewController.swift
//  Cedro Paises
//
//  Created by Matheus Alves on 05/03/17.
//  Copyright © 2017 Matheus Alves. All rights reserved.
//

import UIKit
import SwiftSpinner

class CountriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var countries = [Country]()
    var selectedCountry = Country()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.countries = Country.findAll()
        if countries.count < 250 {
            SwiftSpinner.show("Aguarde...").addTapHandler({
                
            }, subtitle: "Fazendo download dos países. \nIsto pode demorar alguns minutos.")
            RestApiManager().getAllCountries { countries in
                Country.deleteAll()
                Country.insertList(countries: countries)
                self.countries = Country.findAll()
                self.tableView.reloadData()
                SwiftSpinner.hide()
            }
        } else {
            tableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "countryCell",
            for: indexPath) as! CountriesTableViewCell
        
        let row = indexPath.row
        
        cell.countryName.text = countries[row].shortName
        if countries[row].image != "" {
            cell.countryFlag.image = ImageUtils.getImageByBase64(strBase64: countries[row].image)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let indexPath = (self.tableView.indexPathForSelectedRow?.row)!
        self.selectedCountry = self.countries[indexPath]
        if (segue.identifier == "showCountry") {
            let viewController = segue.destination as! CountryViewController
            viewController.country = self.selectedCountry
        }
    }
}
