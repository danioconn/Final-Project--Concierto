//
//  ConciertoUsers.swift
//  Concierto
//
//  Created by Danielle O'Connor on 4/26/22.
//

import Foundation
import Firebase

class ConciertoUsers {
    var conciertoUserArray = [ConciertoUser]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("users").addSnapshotListener { querySnapshot, error in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error?.localizedDescription)")
                return completed()
            }
            self.conciertoUserArray = []
            for document in querySnapshot!.documents {
                let conciertoUser = ConciertoUser(dictionary: document.data())
                conciertoUser.documentID = document.documentID
                self.conciertoUserArray.append(conciertoUser)
            }
            completed()
        }
    }
}
