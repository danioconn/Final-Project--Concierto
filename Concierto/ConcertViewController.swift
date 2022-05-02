//
//  ConcertViewController.swift
//  Concierto
//
//  Created by Danielle O'Connor on 4/25/22.
//

import UIKit


class ConcertViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var concerts = Concerts()
    var chosenState = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        concerts.getData(state: chosenState) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowConcertDetail" {
            let destination = segue.destination as! ConcertDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.concertData = concerts.concertArray[selectedIndexPath.row]
        }
        if segue.identifier == "ShowVenues" {
            let destination = segue.destination as! VenueViewController
            destination.chosenState = chosenState
        }
    }
    

    


}

extension ConcertViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return concerts.concertArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == concerts.concertArray.count - 1 && concerts.continueLoading == true {
            concerts.getData(state: chosenState) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EventTableViewCell
        cell.concertData = concerts.concertArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    @IBAction func unwindFromSeguetoConcertList(unwindSegue: UIStoryboardSegue) {
        print("Unwinding to ConcertViewController")
    }
    
    
}
