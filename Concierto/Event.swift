//
//  Event.swift
//  Concierto
//
//  Created by Danielle O'Connor on 4/26/22.
//

import Foundation
import Firebase

class Event {
    var name: String
    var venue: String
    var date: String
    var documentID: String
    
    
    var dictionary: [String: Any] {
        return ["name": name, "venue": venue, "date": date]
    }
    

    
    init(name:String, venue: String, date: String, documentID: String) {
        self.name = name
        self.venue = venue
        self.date = date
        self.documentID = documentID
    }
    
    override convenience init() {
        self.init(name: "", venue: "", date: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let name = dictionary["name"] as! String? ?? ""
        let venue = dictionary["venue"] as! String? ?? ""
        let date = dictionary["date"] as! String? ?? ""
        self.init(name: name, venue: venue, date: date, documentID: "")
        
    }



    
    func saveData(completion: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        //Create dict to represent the data we want to save
        let dataToSave: [String: Any] = self.dictionary
        //if we have saved a record, we'll have an ID
        if self.documentID == "" {
            var ref: DocumentReference? = nil //Firestore will create a new ID for us
            ref = db.collection("events").addDocument(data: dataToSave){ (error) in
                guard error == nil else {
                    print("ERROR: adding document \(error!.localizedDescription)")
                    return completion(false)
                }
                self.documentID = ref!.documentID
                print("Added document: \(self.documentID)")
                completion(true)
            }
        } else {
            let ref = db.collection("events").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                guard error == nil else {
                    print("ERROR: updating document \(error!.localizedDescription)")
                    return completion(false)
                }
                print("Updated document: \(self.documentID)")
                completion(true)
            }
        }
    }

}
