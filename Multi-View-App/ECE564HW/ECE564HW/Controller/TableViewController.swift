//
//  TableViewController.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/17/22.
//

import UIKit

class TableViewController: UITableViewController {
    var professors: [DukePerson] { DataManager.shared.people.filter { $0.role == Role.Professor.rawValue } }
    var students: [DukePerson] { DataManager.shared.people.filter { $0.role == Role.Student.rawValue } }
    var tas: [DukePerson] { DataManager.shared.people.filter { $0.role == Role.TA.rawValue } }
    var others: [DukePerson] { DataManager.shared.people.filter { $0.role == Role.Other.rawValue } }
    
    var people: [[DukePerson]] { [professors, students, tas, others] }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.title = "Candidates"

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        DataManager.shared.delegate = self
    }
    
    @IBAction func UnwindToMaster(_ sender: UIStoryboardSegue){
        //performSegue(withIdentifier: "ToMaster", sender: self)
        print("Cancel has been tapped!")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // setting the number of sections to the number of Roles
        return roles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        // set to the number of people with role
        if section == 0 {
            return professors.count
        }
        else if section == 1 {
            return students.count
        }
        else if section == 2 {
            return tas.count
        }
        else {
            return others.count
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return Role.Professor.rawValue
        }
        else if section == 1 {
            return Role.Student.rawValue
        }
        else if section == 2 {
            return Role.TA.rawValue
        }
        else {
            return Role.Other.rawValue
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonTableViewCell
        if indexPath.section == 0 {
            let person: DukePerson = professors[(indexPath as NSIndexPath).row]
            cell.setCellValues(person)
        }
        else if indexPath.section == 1 {
            let person: DukePerson = students[(indexPath as NSIndexPath).row]
            cell.setCellValues(person)
        }
        else if indexPath.section == 2 {
            let person: DukePerson = tas[(indexPath as NSIndexPath).row]
            cell.setCellValues(person)
        }
        else {
            let person: DukePerson = others[(indexPath as NSIndexPath).row]
            cell.setCellValues(person)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = people[indexPath.section][indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "ReadOnlyViewController") as! ReadOnlyViewController
        vc.person = person
        show(vc, sender: self)
    }
    
    // usable for the vc below - only
    var addedIndexPath: IndexPath?
    
    // present the viewcontroller for editting if a row isn't selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? ViewController {
            if let section = self.addedIndexPath?.section,
               let row = self.addedIndexPath?.row {
                // This runs if we pressed the "Edit" button.
                let person = people[section][row]
                destination.person = person
            }
            else {
                // This runs if we pressed the "Add" button.
                destination.person = DukePerson.init()
            }
        }
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

}

