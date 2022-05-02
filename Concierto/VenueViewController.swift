//
//  VenueViewController.swift
//  Concierto
//
//  Created by Danielle O'Connor on 4/27/22.
//

import UIKit

class VenueViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var venues = Venues()
    var chosenState = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        venues.getVenueData(state: chosenState) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }

    }
    
    @IBAction func unwindFromSeguetoVenue(unwindSegue: UIStoryboardSegue) {
        print("Unwinding to VenueViewController")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowVenueDetail" {
            let destination = segue.destination as! VenueDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.venueData = venues.venueArray[selectedIndexPath.row]
        }
    }
    

    


}

extension VenueViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues.venueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == venues.venueArray.count - 1 && venues.continueLoading == true {
            venues.getVenueData(state: chosenState) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

 
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VenueTableViewCell
        cell.venueData = venues.venueArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    
}

