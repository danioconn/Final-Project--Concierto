//
//  Venues.swift
//  Concierto
//
//  Created by Dani O'Connor on 4/27/22.
//

import Foundation
import UIKit

class Venues {
    
    struct Returned: Codable {
        var venues: [VenuesData]
    }
    

    struct VenuesData: Codable {
        var name: String
        var city: String
        var url: String
        var address: String

    }


    
    var venueArray: [VenueData] = []
    
    
    func getVenueData(state: String,completed: @escaping () -> ()) {
        let url = "https://api.seatgeek.com/2/venues?state=\(state)&client_id=\(APIkeys.seatGeekKey)"
        print("STATE CHOSEN: \(state)")
        let urlString = url
        print(urlString)
        guard let url = URL(string: urlString) else {
            completed()
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print("ERROR")
            }
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)

                for data in returned.venues {
                    self.venueArray.append(VenueData(name: data.name, location: data.city, url: data.url, address: data.address))
                }
            } catch {
                print("JSON Error: \(error)")
            }
            completed()
        }
        task.resume()
    }
}
