//
//  ConciertoUserTableViewCell.swift
//  Concierto
//
//  Created by Danielle O'Connor on 4/26/22.
//

import UIKit
import Firebase
import FirebaseAuthUI
import SDWebImage

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter
}()

class ConciertoUserTableViewCell: UITableViewCell {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userSinceLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var conciertoUser: ConciertoUser! {
        didSet {
            displayLabel.text = conciertoUser.displayName
            emailLabel.text = conciertoUser.email
            userSinceLabel.text = "\(dateFormatter.string(from: conciertoUser.userSince))"
            
            userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2
            userImageView.clipsToBounds = true
            
            guard let url = URL(string: conciertoUser.photoURL) else {
                userImageView.image = UIImage(systemName: "person.crop.circle")
                return
            }
            userImageView.sd_imageTransition = .fade
            userImageView.sd_imageTransition?.duration = 0.1
            userImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.crop.circle"))

        }
    }

}
