//
//  ViewController.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/3/22.
//

import UIKit



class ViewController: UIViewController, UITextFieldDelegate {
    //var person = DukePerson()
    
    // add Team - add later
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var NetIDField: UITextField!
    @IBOutlet weak var fnameField: UITextField!
    @IBOutlet weak var lnameField: UITextField!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var progLangField: UITextField!
    @IBOutlet weak var hobbyField: UITextField!
    @IBOutlet var genderField: UISegmentedControl!
    var genderSelect = "Other"
    @IBOutlet weak var picker: UIPickerView!
    var roleField: String = "Other"
    @IBOutlet weak var outputField: UILabel!
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        
        NetIDField.becomeFirstResponder()
        
        DataManager.shared.printPeople()
    }
    
    // MARK: - IBActions
    
    @IBAction func segmentedControlAction (_ sender: UISegmentedControl){
        // receive the segmentedControlAction.titleOfSegment to pass into Gender
        let col = genderField.selectedSegmentIndex
        let selected = genders[col]
        let my_gender = Gender(rawValue: selected.rawValue)!
        genderSelect = my_gender.rawValue
        print("Gender received!")
    }
    
    @IBAction func addAction(_ sender: Any) {
//        var view = UIView()
//        view = sender as! UIView
        
        if NetIDField.text != "" && fnameField.text != ""{
            addUpdate()
            //view.isUserInteractionEnabled = true
        } else {
            clearFields()

        }
        
        print("Add/Update has been tapped!")
        
    }
    
    @IBAction func findAction(_ sender: Any) {
        if let fn = fnameField.text,
           let ln = lnameField.text,
           let person = DataManager.shared.find(firstname: fn, lastname: ln) {
            
            print(person)
            // if there is match, the output field is set to the description output.
            outputField.text = person.description
        }
        else {
            // if the person is not found, then display "The person was not found"
            outputField.text = "The person was not found!"
        }
    }
    
    @IBAction func clearAction(_ sender: Any) {
        clearFields()
        print("Clear has been tapped!")
    }

    // MARK: - Private Helpers

    
    // add input from textfields to the database
    private func addUpdate () {
        
        guard let tempPerson = getTempPerson() else { return } // ends immediately if no temp person is created
        
        // True if peopple array does not contain any element such that the element's 'netId' == NetIDField.text
        // (I.e. Guard/Ensure that the person does not exist in the database already)
        guard !DataManager.shared.people.contains(where: { $0.netid == NetIDField.text }) else {

            
            // We found them in the system...
            DataManager.shared.update(person: tempPerson)
            outputField.text = "The person has been updated!"
            return
        }
        
        // As expected, we continue if we didn't find them in the database...
        DataManager.shared.add(person: tempPerson)
        outputField.text = "The person has been added!"
    }
    
    private func getTempPerson() -> DukePerson? {
        guard let ni = NetIDField.text else {
            return nil
        }
        let fn = fnameField.text ?? ""
        let ln = lnameField.text ?? ""
        let wf = fromField.text ?? ""
        let gn = genderSelect
        let hb = hobbyField.text?.components(separatedBy: ", ") ?? [String]()
        let ro = roleField
        let dg = ""
        let lg = progLangField.text?.components(separatedBy: ", ") ?? [String]()
        let pc = personImageView.image?.toString() ?? ""
        let tm = ""
        let em = ""
        let dp = ""
        let id = ""
        
        let tempPerson = DukePerson(firstname: fn.capitalized, lastname: ln.capitalized, wherefrom: wf, gender: gn, hobbies: hb, role: ro, degree: dg, languages: lg, picture: pc, team: tm, netid: ni, email: em, department: dp, id: id)
        
        return tempPerson
    }
    
    // End

    func clearFields(){
        NetIDField.text = ""
        fnameField.text = ""
        lnameField.text = ""
        fromField.text = ""
        hobbyField.text = ""
        progLangField.text = ""
        //personImageView.image = "".toImage() - no need to clear the image b/c user can reselect
        outputField.text = ""
        //countField.text = ""
        
        return
    }
}
    
// MARK: - UIPickerViewDataSource

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
    
// MARK: - UIImagePickerDelegate

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

