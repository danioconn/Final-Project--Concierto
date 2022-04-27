//
//  ConciertoUserViewController.swift
//  Concierto
//
//  Created by Danielle O'Connor on 4/26/22.
//

import UIKit

class ConciertoUserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var conciertoUsers: ConciertoUsers!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        conciertoUsers = ConciertoUsers()
        conciertoUsers.loadData {
            self.tableView.reloadData()
        }
    }
    


}

extension ConciertoUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conciertoUsers.conciertoUserArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! ConciertoUserTableViewCell
        cell.conciertoUser = conciertoUsers.conciertoUserArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
