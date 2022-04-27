//
//  VenueTableViewCell.swift
//  Concierto
//
//  Created by Dani O'Connor on 4/27/22.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var venueData: VenueData! {
        didSet {
            venueLabel.text = venueData.name
            cityLabel.text = "City: \(venueData.location)"
        }
    }

}
