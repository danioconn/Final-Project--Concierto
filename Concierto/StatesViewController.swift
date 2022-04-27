//
//  StatesViewController.swift
//  Concierto
//
//  Created by Danielle O'Connor on 4/25/22.
//

import UIKit
var userState = ""

class StatesViewController: UIViewController {

    @IBOutlet weak var statePicker: UIPickerView!
    var states = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "Utah", "VT", "VA", "WA", "WV", "WI", "WY"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statePicker.delegate = self
        statePicker.dataSource = self

    }
    
    
    @IBAction func continueButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowConcerts", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowConcerts" {
            let destination = segue.destination as! ConcertViewController
            let component = 0
            let row = statePicker.selectedRow(inComponent: component)
            let title = statePicker.delegate?.pickerView?(statePicker, titleForRow: row, forComponent: component)
            destination.chosenState = title ?? ""
        }
    }
    
    @IBAction func unwindFromSegue(unwindSegue: UIStoryboardSegue) {
        print("Unwinding to StatesViewController")
    }

}

extension StatesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return states.count
        }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: states[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "FontColor")!])
    }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return states[row]
        }

        //Called when the user changes the selection...
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            userState = states[row]
            print(userState)
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        }
}
