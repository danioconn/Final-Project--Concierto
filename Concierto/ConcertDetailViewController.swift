//
//  ConcertDetailViewController.swift
//  Concierto
//
//  Created by Danielle O'Connor on 4/26/22.
//

import UIKit
import SafariServices

class ConcertDetailViewController: UIViewController {
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var concertData: ConcertData!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
    }
    
    @IBAction func unwindFromSeguetoConcertDetail(unwindSegue: UIStoryboardSegue) {
        print("Unwinding to ConcertDetailViewController")
    }
    
  

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BuyTickets" {
            let destination = segue.destination as! WebpageViewController
            destination.url = concertData.url
        }
        
    }
    
    func updateUserInterface() {
        imageView.layer.borderColor = UIColor(named: "PrimaryColor")?.cgColor
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.borderWidth = 5

        eventLabel.text = concertData.name
        venueLabel.text = "Venue: \(concertData.venue)"
        cityLabel.text = "City: \(concertData.location)"
        typeLabel.text = "Type: \(concertData.type)"
        dateLabel.text = "Date: \(concertData.date)"
        imageView.loadFrom(URLAddress: concertData.image)
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
