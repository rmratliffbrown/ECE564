//
//  ReadOnlyViewController.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/21/22.
//

import UIKit

class ReadOnlyViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var personImage: UIImageView!
    
    @IBOutlet weak var netidLabel: UILabel!
    @IBOutlet weak var fnameLabel: UILabel!
//    @IBOutlet weak var lnameLabel: UILabel!
    @IBOutlet weak var wherefromLabel: UILabel!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var hobbiesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    
    
    var person: DukePerson!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = "View-Only"

        // Do any additional setup after loading the view.
        if person.firstname == "Rashaad" && person.lastname == "Ratliff-Brown" {
            personImage.image = UIImage(named: "image")
        } else {
            personImage.image = UIImage(systemName: "person.circle.fill")
        }
        
        //personImage.image = person.picture.toImage()
        personImage.makeRounded()
        
        netidLabel.text = "NetID: " + person.netid
        fnameLabel.text = "Name: " + person.firstname + " " + person.lastname
        //lnameLabel.text = "Last Name: " + person.lastname
        wherefromLabel.text = "Hometown: " + person.wherefrom
        langLabel.text = "Language(s): " + person.languages.joined(separator: ", ")
        hobbiesLabel.text = "Hobbies: " + person.hobbies.joined(separator: ", ")
        genderLabel.text = "Gender: " + person.gender
        roleLabel.text = "Role: " + person.role
        departmentLabel.text = "Department: " + person.department
        degreeLabel.text = "Degree: " + person.degree
        emailLabel.text = "Email: " + person.email
        teamLabel.text = "Team: " + person.team
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
