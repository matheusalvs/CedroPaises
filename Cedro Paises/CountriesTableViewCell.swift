//
//  CountriesTableViewCell.swift
//  Cedro Paises
//
//  Created by Matheus Alves on 05/03/17.
//  Copyright © 2017 Matheus Alves. All rights reserved.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var countryName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
