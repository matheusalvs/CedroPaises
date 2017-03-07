//
//  CountryTableViewController.swift
//  Cedro Paises
//
//  Created by Matheus Alves on 06/03/17.
//  Copyright © 2017 Matheus Alves. All rights reserved.
//

import UIKit

class CountryTableViewController: UITableViewController {

    @IBOutlet weak var visitedDatePicker: UIDatePicker!
    @IBOutlet weak var visitedSwitch: UISwitch!
    @IBOutlet weak var lblCallingCode: UILabel!
    @IBOutlet weak var lblLongName: UILabel!
    @IBOutlet weak var lblVisitedDate: UILabel!
    var country = Country()
    var datePickerHidden = false
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        datePickerChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLongName.text = self.country.longName
        lblCallingCode.text = self.country.callingCode
        if self.country.visitedDate != nil {
            visitedDatePicker.date = self.country.visitedDate as! Date
            visitedSwitch.setOn(true, animated: false)
        } else {
            visitedSwitch.setOn(false, animated: false)
        }
        datePickerChanged()
        
    }
    
    func datePickerChanged () {
        lblVisitedDate.text = DateFormatter.localizedString(from: visitedDatePicker.date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
    }
    
    func save() {
        let updatedCountry = Country()
        updatedCountry.id = self.country.id
        updatedCountry.iso = self.country.iso
        updatedCountry.shortName = self.country.shortName
        updatedCountry.longName = self.country.longName
        updatedCountry.status = self.country.status
        updatedCountry.culture = self.country.culture
        updatedCountry.image = self.country.image
        updatedCountry.visitedDate = self.country.visitedDate
        
        if self.visitedSwitch.isOn {
            updatedCountry.visitedDate = self.visitedDatePicker.date as NSDate?
        } else {
            updatedCountry.visitedDate = nil
        }
        Country.update(country: updatedCountry)
    }
}
