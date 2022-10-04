//
//  ViewController.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/3/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var NetIDField: UITextField!
    
    @IBOutlet weak var fnameField: UITextField!
    
    @IBOutlet weak var lnameField: UITextField!
    
    @IBOutlet weak var fromField: UITextField!
    
    @IBOutlet weak var progLangField: UITextField!
    
    @IBOutlet weak var hobbyField: UITextField!
    
    @IBOutlet weak var outputField: UILabel!
    
    @IBOutlet weak var countField: UILabel!
    
    @IBAction func addAction(_ sender: Any) {
                
        addUpdate()
        print("Add/Update has been tapped!")
    }
    
    @IBAction func findAction(_ sender: Any) {
        
       findItem()
       print("Find has been tapped!")
    }
    
    @IBAction func clearAction(_ sender: Any) {
        clearFields()
        print("Clear has been tapped!")
    }
    
    
    // create an array to house the data
    var database = [DukePerson]()
    
    // hard code objects for self and Professor Telford
    let student = DukePerson("Rashaad", "Ratliff-Brown",  "Raleigh, NC", "Triathlon", "rmr53", "Python")
    let professor = DukePerson("Ric", "Telford", "Chatham County, NC", "Golf", "rt113", "Swift")
    
    // add input from textfields to the database
    func addUpdate () {
        
        // You would first do a find - if there is a match on "netid" then the old entry would be removed and the new entry would replace it.
        for person in database{
            
            // find items in the database using the key (netid)
            // If there is not a match, you would add the new entry to the database.
            if (person.netId == NetIDField.text){
                
                // optional handling, else -> default: ""
                person.fname = fnameField.text ?? ""
                person.lname = lnameField.text ?? ""
                person.from = fromField.text ?? ""
                person.hobby = hobbyField.text ?? ""
                person.progLang = progLangField.text ?? ""
                
                // The output field would display "The person has been updated!"
                outputField.text = "The person has been updated!"
                
                return
            }
        }
        
        // create variable to hold each instance
        let tempPerson = DukePerson()
        
        tempPerson.fname = fnameField.text ?? ""
        tempPerson.fname = fnameField.text ?? ""
        tempPerson.lname = lnameField.text ?? ""
        tempPerson.from = fromField.text ?? ""
        tempPerson.hobby = hobbyField.text ?? ""
        tempPerson.netId = NetIDField.text ?? ""
        tempPerson.progLang = progLangField.text ?? ""
        
        database.append(tempPerson)
        
        // Set output field to display "The person has been added"
        outputField.text = "The person has been added!"
        
        // BONUS: add a label to indicate the number of objects in the database
        countField.text = String(database.count)
        let msg = "There are \(countField.text!) objects in the database."
        
        countField.text = msg
        
        return
    }
    
    func findItem(){
        
        for person in database{
            // if object's first and last name match
            if (person.fname == fnameField.text && person.lname == lnameField.text) {
                
                // if there is no match, the output field is set to the description output.
                outputField.text = person.description
                
                return
            }
            
          }
        
        // if the person is not found, then display "The person was not found"
        outputField.text = "The person was not found!"
        
        return
    }
    
    func clearFields(){
        NetIDField.text = ""
        fnameField.text = ""
        lnameField.text = ""
        fromField.text = ""
        hobbyField.text = ""
        progLangField.text = ""
        
        outputField.text = ""
        countField.text = ""
        
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // add student and professor to array as base objects
        database.append(student)
        database.append(professor)
        
        // empty the label on load
        countField.text = ""
        
        // empty the label on load
        outputField.text = ""
        
        
        
    }
    
    

    

    

    


}

