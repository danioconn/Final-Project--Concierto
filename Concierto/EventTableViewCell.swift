//
//  EventTableViewCell.swift
//  Concierto
//
//  Created by Danielle O'Connor on 4/26/22.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var concertData: ConcertData! {
        didSet {
            eventLabel.text = concertData.name
            venueLabel.text = concertData.venue
            cityLabel.text = concertData.location
        }
    }
    

}
