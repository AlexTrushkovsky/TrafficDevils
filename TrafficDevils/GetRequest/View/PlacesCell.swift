//
//  PlacesCell.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 04.05.2021.
//

import UIKit

class PlacesCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        cityImage.layer.cornerRadius = 15
        self.selectionStyle = .none
    }

}

