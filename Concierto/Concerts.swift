//
//  Concerts.swift
//  Concierto
//
//  Created by Danielle O'Connor on 4/25/22.
//

import Foundation
import UIKit

class Concerts {
    
    struct Returned: Codable {
        var events: [EventsData]
    }
    

    struct EventsData: Codable {
        var type: String
        var venue: Location
        var performers: [Performer]
        var id: Int
        var url: String
        var datetime_utc: String

    }

    struct Performer: Codable {
        var name: String
        var image: String?
    }

    struct Location: Codable {
        var display_location: String!
        var name: String
        var state: String
    }



    
    
    var concertArray: [ConcertData] = []

    var pageNumber = 1
    var continueLoading = true

    
    func getData(state: String,completed: @escaping () -> ()) {
        let url = "https://api.seatgeek.com/2/events?venue.state=\(state)&client_id=\(APIkeys.seatGeekKey)&page=\(pageNumber)"
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
                if returned.events.count > 0 {
                        self.pageNumber = self.pageNumber + 1
                    for data in returned.events {
                        self.concertArray.append(ConcertData(venue: data.venue.name, name: data.performers.first?.name ?? "", location: data.venue.display_location, type: data.type, url: data.url, image: data.performers.first?.image ?? "", date: data.datetime_utc, state: data.venue.state))
                    }
                } else {
                    self.continueLoading = false
                }
            } catch {
                print("JSON Error: \(error)")
            }
            completed()
        }
        task.resume()
    }
}
