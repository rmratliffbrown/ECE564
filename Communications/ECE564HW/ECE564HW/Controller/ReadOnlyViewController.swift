//
//  ReadOnlyViewController.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/21/22.
//

import UIKit

class ReadOnlyViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var netidLabel: UILabel!
    @IBOutlet weak var fnameLabel: UILabel!
//    @IBOutlet weak var lnameLabel: UILabel!
    @IBOutlet weak var wherefromLabel: UILabel!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var hobbiesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    
//    @IBOutlet weak var outputLabel: UILabel!
    
    var person: DukePerson!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = "View-Only"

        // Do any additional setup after loading the view.

        
        // TODO: Set images
//        if person.firstname == "Rashaad" && person.lastname == "Ratliff-Brown" {
//            personImage.image = UIImage(named: "image")
//        } else {
//            personImage.image = UIImage(named: person.picture) ?? UIImage(systemName: "person.circle.fill")
//        }
        personImage.image = person.picture.toImage() ?? UIImage(systemName: "person.circle.fill")
        personImage.makeRounded()
        descriptionLabel.text = person.description
        print(person.department)
        
        
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

// MARK: - UITableViewDataSource

extension ReadOnlyViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 13
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "readOnlyCell")!
        if indexPath.section == 0 {
            cell.textLabel?.text = person.netid
        }
        else if indexPath.section == 1 {
            cell.textLabel?.text = person.firstname
        }
        else if indexPath.section == 2 {
            cell.textLabel?.text = person.lastname
        }
        else if indexPath.section == 3 {
            cell.textLabel?.text = person.wherefrom
        }
        else if indexPath.section == 4 {
            cell.textLabel?.text = person.languages.joined(separator: ", ")
        }
        else if indexPath.section == 5 {
            cell.textLabel?.text = person.hobbies.joined(separator: ", ")
        }
        else if indexPath.section == 6 {
            cell.textLabel?.text = person.gender
        }
        else if indexPath.section == 7 {
            cell.textLabel?.text = person.role
        }
        else if indexPath.section == 8 {
            cell.textLabel?.text = person.department
        }
        else if indexPath.section == 9 {
            cell.textLabel?.text = person.degree
        }
        else if indexPath.section == 10 {
            cell.textLabel?.text = person.team
        }
        else if indexPath.section == 11 {
            cell.textLabel?.text = person.email
        } else if indexPath.section == 12 {
            cell.textLabel?.text = person.id
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitles: [String] = ["Net ID", "First Name", "Last Name", "Hometown", "Languages", "Hobbies", "Gender", "Role", "Department", "Degree", "Team", "Email", "ID"]
        return sectionTitles[section]
    }
}

// MARK: - UITableViewDelegate

extension ReadOnlyViewController: UITableViewDelegate {
    
}

