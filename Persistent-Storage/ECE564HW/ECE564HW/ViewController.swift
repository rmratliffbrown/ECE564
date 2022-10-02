//
//  ViewController.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/3/22.
//

import UIKit

let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
let ArchiveURL = DocumentsDirectory.appendingPathComponent("in-phone-memory-saved-file")

class ViewController: UIViewController, UITextFieldDelegate {
    
    // add Team - add later
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var NetIDField: UITextField!
    @IBOutlet weak var fnameField: UITextField!
    @IBOutlet weak var lnameField: UITextField!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var progLangField: UITextField!
    @IBOutlet weak var hobbyField: UITextField!
    @IBOutlet var genderField: UISegmentedControl!
    var genderSelect = ""
    @IBOutlet weak var picker: UIPickerView!
    var roleField: String = ""
    
    @IBAction func segmentedControlAction (_ sender: UISegmentedControl){
        // receive the segmentedControlAction.titleOfSegment to pass into Gender
        let col = genderField.selectedSegmentIndex
        let selected = genders[col]
        let my_gender = Gender(rawValue: selected.rawValue)!
        genderSelect = my_gender.rawValue
        print("Gender received!")
    }
    
    @IBOutlet weak var outputField: UILabel!
    
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
    
//    var element: [DukePersonElement] = {
//        do {
//            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//                .appendingPathComponent("ECE564Cohort.json")
//
//            let data = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            let items = try decoder.decode([DukePersonElement].self, from: data)
//            return items
//        } catch {
//            print(error.localizedDescription)
//            return []
//        }
//    }()
    
    // this decode reads file ece564.json!! on-my-desktop-directoty-file
    var database: [DukePersonElement] = Bundle.main.decode(file: "ECE564Cohort.json") ?? [DukePersonElement]()
    
    // add input from textfields to the database
    func addUpdate () {
        
        // create array to house elements
        //var newArray = database
        
        // You would first do a find - if there is a match on "netid" then the old entry would be removed and the new entry would replace it.
        for var person in database{
            
            // find items in the database using the key (netid)
            // If there is not a match, you would add the new entry to the database.
            if (person.netid == NetIDField.text){
                
                // optional handling, else -> default: ""
                person.firstname = fnameField.text ?? ""
                person.lastname = lnameField.text ?? ""
                person.wherefrom = fromField.text ?? ""
                person.gender = genderSelect
                person.hobbies = hobbyField.text?.components(separatedBy: ",") ?? [String]()
                person.role = roleField
                // missing degree
                person.languages = progLangField.text?.components(separatedBy: ",") ?? [String]()
                // missing picture - will add
                person.picture = personImageView.image?.toString() ?? ""
                // missing team
                // missing email
                // missing department
                // missing id
                
                // The output field would display "The person has been updated!"
                
                // Only output update message if there is a netid inserted
                if (NetIDField.text != ""){
                    outputField.text = "The person has been updated!"
                }
                
                database.append(person)

                break
            }
            
            // save the current state of the array
            print(saveToJSON(database))
        }

        // create instance from Codable object
        let tempPerson = DukePerson()
            
        tempPerson.firstname = fnameField.text ?? ""
        let fn = tempPerson.firstname
        tempPerson.lastname = lnameField.text ?? ""
        let ln = tempPerson.lastname
        tempPerson.wherefrom = fromField.text ?? ""
        let wf = tempPerson.wherefrom
        tempPerson.gender = genderSelect
        let gn = tempPerson.gender
        tempPerson.netid = NetIDField.text ?? ""
        let ni = tempPerson.netid
        tempPerson.hobbies = hobbyField.text?.components(separatedBy: ",") ?? [String]()
        let hb = tempPerson.hobbies
        tempPerson.role = roleField
        let ro = tempPerson.role
        tempPerson.degree = ""
        let dg = tempPerson.degree
        tempPerson.languages = progLangField.text?.components(separatedBy: ",") ?? [String]()
        let lg = tempPerson.languages
        // implements a #imageLiteral to set the default to an avatar
        tempPerson.picture = personImageView.image?.toString() ?? #imageLiteral(resourceName: "default").toString()!
        let pc = tempPerson.picture
        tempPerson.team = ""
        let tm = tempPerson.team
        tempPerson.email = ""
        let em = tempPerson.email
        tempPerson.department = ""
        let dp = tempPerson.department
        tempPerson.id = ""
        let id = tempPerson.id
        
        let temp = DukePersonElement(fn, ln, wf, gn, hb, ro, dg, lg, pc, tm, ni, em, dp, id)
        
        database.append(temp)
        
        // save the current state of the array -> this does not work
        print(saveToJSON(database))
        
        
        if (fnameField.text != ""){
            // Set output field to display "The person has been added"
            outputField.text = "The person has been added!"
        }

        // BONUS: add a label to indicate the number of objects in the database
        //countField.text = String(database.count)
        
        //let msg = "There are \(countField.text!) objects in the database."
        
        //countField.text = msg
        
        return
    }
    
    func update(){
        // move update function
    }
    
    func add(){
        // add person to database
    }
    
    

    
    func findItem(){
        
        for person in database{
            // if object's first and last name match + preventing user from triggering description message
            if (person.firstname == fnameField.text && person.lastname == lnameField.text && fnameField.text != "") {
                
                // if there is match, the output field is set to the description output.
                outputField.text = person.description
                
                // the default image also appears
                if (fnameField.text == "Rashaad" && lnameField.text == "Ratliff-Brown"){
                    personImageView.image = #imageLiteral(resourceName: "image")
                } else {
                    personImageView.image = #imageLiteral(resourceName: "default")
                }
                
                return
            }
            
            if (fnameField.text != "" && lnameField.text != ""){
                
                // if the person is not found, then display "The person was not found"
                outputField.text = "The person was not found!"
            }
            
          }

        return
    }
    
    func clearFields(){
        NetIDField.text = ""
        fnameField.text = ""
        lnameField.text = ""
        fromField.text = ""
        hobbyField.text = ""
        progLangField.text = ""
        personImageView.image = #imageLiteral(resourceName: "default")
        outputField.text = ""
        //countField.text = ""
        
        return
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // add student and professor to array as base objects
        //database.append(student)
        //database.append(professor)
        
        // empty the label on load
        //countField.text = ""
        
        // empty the label on load
        outputField.text = ""
        
        //let image = UIImage(data: person.picture)
        
        // allow user to click/select an image from their camera roll or take a picture
        //personImageView.image = UIImage(named: "default")
        personImageView.makeRounded()
        
        //picker view
        
        picker.delegate = self
        picker.dataSource = self
        picker.frame = CGRect(x: 37, y: 619, width:313, height: 34)
        picker.layer.cornerRadius = 4
        
        let x = loadJSON()
        for item in x {
            database.append(item)
        }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
            return roles[row].rawValue
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            // set role for the person object
            roleField = roles[row].rawValue
        }
        
    }

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Image tap gesture
    @IBAction func addImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // let the user pick media from his photo library.
        let imagePickerController = UIImagePickerController()
        
        // Allows to picked photos.
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
        print("Image picker pressed!")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        personImageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
}

