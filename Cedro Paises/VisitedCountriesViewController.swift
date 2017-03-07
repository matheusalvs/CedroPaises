//
//  VisitedCountriesViewController.swift
//  Cedro Paises
//
//  Created by Matheus Alves on 06/03/17.
//  Copyright © 2017 Matheus Alves. All rights reserved.
//

import UIKit

class VisitedCountriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var countries = [Country]()
    var selectedCountry = Country()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.countries = Country.findAllVisited()
        self.tableView.reloadData()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension VisitedCountriesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "visitedCountryCell",
            for: indexPath) as! VisitedCountriesTableViewCell
        
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
        if (segue.identifier == "showVisitedCountry") {
            let viewController = segue.destination as! CountryViewController
            viewController.country = self.selectedCountry
        }
    }

}
