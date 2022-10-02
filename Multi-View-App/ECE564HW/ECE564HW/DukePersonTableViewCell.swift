//
//  DukePersonTableViewCell.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/17/22.
//

import Foundation
import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personDescription: UILabel!
    
    @IBOutlet weak var personImageView: UIImageView!

    
    // Set Person values
    func setCellValues(_ person: DukePerson) {
        personNameLabel.text = person.firstname + " " + person.lastname
        personDescription.text = person.description
        
        // TODO: Set images
        if person.firstname == "Rashaad" && person.lastname == "Ratliff-Brown" {
            personImageView.image = UIImage(named: "image")
        } else {
            personImageView.image = UIImage(systemName: "person.circle.fill")
        }
        personImageView.makeRounded()

    }
}
