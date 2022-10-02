//
//  TableViewController.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/17/22.
//

import UIKit
import MessageUI

class TableViewController: UITableViewController, UISearchResultsUpdating, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate{
    
    // computed values
    var filteredPeople: [DukePerson] = DataManager.shared.people
    
    var professors: [DukePerson] { filteredPeople.filter { $0.role == Role.Professor.rawValue } }
    var students: [DukePerson] { filteredPeople.filter { $0.role == Role.Student.rawValue } }
    var tas: [DukePerson] { filteredPeople.filter { $0.role == Role.TA.rawValue } }
    var others: [DukePerson] { filteredPeople.filter { $0.role == Role.Other.rawValue } }
    
    var people: [[DukePerson]] { [professors, students, tas, others] }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var editedIndexPath: IndexPath?
    
    private let progressView:UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .bar)
        pv.tintColor = .systemBlue
        pv.progressTintColor = .systemBlue
        return pv
    }()

    fileprivate func extractedFunc() {
        progressView.isHidden = true
        view.addSubview(progressView)
        progressView.frame = CGRect(x: 10, y: 0, width: view.frame.size.width - 20, height: 20)
        progressView.setProgress(0, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.title = "Candidates"
        
        // adding search controller to nav
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        extractedFunc()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        DataManager.shared.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        // Implements my custom contains method defined in the person class.
        if text.isEmpty {
            self.filteredPeople = DataManager.shared.people
            self.tableView.reloadData()
        }
        else {
            let matchingPeople = DataManager.shared.people.filter({ $0.contains(searchText: text) })
            self.filteredPeople = matchingPeople
            self.tableView.reloadData()
        }
    }
    
   @IBAction func refresh(_ sender: Any) {
       self.presentLoadingSpinner(withMessage: "Fetching...") { alert in
           DataManager.shared.makeGetRequest { people in
               guard let people = people else {
                   print("Failed.")
                   return
               }
               DispatchQueue.main.async {
                   alert.dismiss(animated: true)
               }
               DataManager.shared.people = people
           }
       }
    }
    
    
    @IBAction func UnwindToMaster(_ sender: UIStoryboardSegue){
        // setting the index path to nil to handle case of user changing mind about editing, then wanting to add
        editedIndexPath = nil
        print("Unwind!")
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
    
    
    // allows removal
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
        
    }
    
    // handles the slide function
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // delete with slide - complete
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){ _, indexPath in
            let personToRemove = self.people[indexPath.section][indexPath.row]
            print("Delete: " + personToRemove.firstname)
            // data.manager.shared is accessing its remove function, then receiving personToRemove
            self.filteredPeople.removeAll(where: { $0.netid == personToRemove.netid })
            DataManager.shared.remove(person: personToRemove)
        }
        
        // update with slide - complete
        let updateAction = UITableViewRowAction(style: .destructive, title: "Update"){ _, indexPath in
            let personToUpdate = self.people[indexPath.section][indexPath.row]
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            print("Update: " + personToUpdate.firstname)
            
            // call the Server API to update person's information.
            DataManager.shared.makePUTRequest(dukePerson: personToUpdate)
            tableView.reloadData()
        }
            
        // email with slide - complete
        let emailAction = UITableViewRowAction(style: .normal, title: "Email"){ _, indexPath in
            let personToEmail = self.people[indexPath.section][indexPath.row]
            if MFMailComposeViewController.canSendMail(){
                let vc = MFMailComposeViewController()
                vc.delegate = self
                vc.setSubject("Test Subject to \(personToEmail.firstname)")
                vc.setToRecipients(["\(personToEmail.netid)@duke.edu"])
                vc.setMessageBody("This is a test email to \(personToEmail.firstname) \(personToEmail.lastname) ", isHTML: false)
                //vc.addAttachmentData()
                self.present(UINavigationController(rootViewController: vc), animated: true)
            } else {
                print("Email: " + personToEmail.netid)
            }
        }
            
        // edit with slide - complete
        let editAction = UITableViewRowAction(style: .normal, title: "Edit"){ _, indexPath in
            let editPressed = true
            let personToEdit = self.people[indexPath.section][indexPath.row]
            _ = self.storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            print("Edit: " + personToEdit.firstname)
            
            // go to Edit mode for that person instead of ViewOnly
                self.editedIndexPath = indexPath
                self.performSegue(withIdentifier: "modify", sender: self)
            
            // call the Server API to update person's information.
            DataManager.shared.makePOSTRequest(dukePerson: personToEdit)
            
        }
        
        updateAction.backgroundColor = .systemGreen
        emailAction.backgroundColor = .systemGray
        editAction.backgroundColor = .systemBlue
        
        return [deleteAction, updateAction, editAction, emailAction]
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? ViewController {
            if let section = self.editedIndexPath?.section,
               let row = self.editedIndexPath?.row {
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

// MARK: - DataManagerDelegate

extension TableViewController: DataManagerDelegate {
    func peopleChanged() {
        self.filteredPeople = DataManager.shared.people
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
