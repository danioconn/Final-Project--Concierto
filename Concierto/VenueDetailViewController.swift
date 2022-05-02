//
//  VenueDetailViewController.swift
//  Concierto
//
//  Created by Dani O'Connor on 4/27/22.
//

import UIKit

class VenueDetailViewController: UIViewController {
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var venueData: VenueData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
    }
    
    func updateUserInterface() {
        venueLabel.text = venueData.name
        cityLabel.text = "City: \(venueData.location)"
        addressLabel.text = "Address: \(venueData.address)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SeeWebsite" {
            let destination = segue.destination as! VenueWebpageViewController
            destination.url = venueData.url
        }
        
    }

    
    @IBAction func unwindFromSeguetoVenueDetail(unwindSegue: UIStoryboardSegue) {
        print("Unwinding to VenueDetailViewController")
    }
}

    


