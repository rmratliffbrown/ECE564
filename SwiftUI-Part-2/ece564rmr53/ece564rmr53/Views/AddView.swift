//
//  AddView.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/2/22.
//

// was working on adding ability to add picture

import SwiftUI
import PhotosUI

struct AddView: View {
    @StateObject private var viewModel = DataManager.shared
    @Environment(\.dismiss) private var dismiss
    
    @State private var picture = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var wherefrom = ""
    @State private var hobbies = ""
    @State private var degree = ""
    @State private var languages = ""
    @State private var team = ""
    @State private var netid = ""
    @State private var email = ""
    @State private var selectedRole = "Other"
    @State private var selectedGender = "Other"
    
    @State private var selectedImageData: Data? = nil
    @State private var presentingAlert = false
    @State private var showGallerySheet = false
    @State private var showCameraSheet = false
    @State private var imageData: String?
    @State private var image: UIImage?
    
    var body: some View {
        NavigationView {
            formView()
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline).toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading){
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing){
                        Button(action: {
                            saveDataToDatabase()
                            dismiss()
                        }, label: {
                            Text("Save")
                        })
                    }
                }
                .alert("Please Select an Option", isPresented: $presentingAlert) {
                    Button("Gallery", action: {
                        showGallerySheet = true
                    })
                    Button("Camera", role: .destructive, action: {
                        showCameraSheet = true
                    })
                    Button("Cancel", role: .cancel, action: {})
                }
                .sheet(isPresented: $showGallerySheet,onDismiss: loadImage) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    
                }
                .sheet(isPresented: $showCameraSheet,onDismiss: loadImage) {
                    ImagePicker(sourceType: .camera, selectedImage: self.$image)
                }
        } // NavigationView
    }
    
    func formView() -> some View {
        Form {
            HStack(alignment: .top) {
                VStack {
                    ZStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(.blue)
                        
                        if let imageUI = image {
                            Image(uiImage: imageUI)
                                .resizable()
                                .clipShape(Circle())
                        }
                    } // ZStack
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "pencil.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 30))
                            .foregroundColor(.green)
                    }
                    .frame(width: 150, height: 150).foregroundColor(.blue)
                    .onTapGesture {
                        withAnimation(.spring()){
                            self.presentingAlert = true
                        }
                    }
                        
                    Text(firstname + " " + lastname).font(Font.title)
                    Text(selectedRole)
                }
            } // HStack
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .listRowInsets(EdgeInsets())
            .background(Color(.systemGroupedBackground))
            
            
            Section(header: Text("Information")) {
                Group {
                    TextField("netid", text: $netid)
                    TextField("First Name", text: $firstname)
                    TextField("Last Name", text: $lastname)
                    TextField("Email", text: $email)
                        .disabled(true)
                        .onChange(of: netid) { newValue in
                            email = newValue + "@duke.edu"
                        }
                    TextField("Hometown", text: $wherefrom)
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue)
                                .tag(gender.rawValue)
                        }
                        
                    }
                } // Group
           
                // Group since you can only fit 10 items max
                Group {
                    TextField("Hobbies", text: $hobbies)
                    Picker("Role", selection: $selectedRole) {
                        ForEach(Role.allCases, id: \.self) { role in
                            Text(role.rawValue)
                                .tag(role.rawValue)
                        }
                    }
                    TextField("Degree", text: $degree)
                    TextField("Languages", text: $languages)
                    TextField("Team", text: $team)
                } // Group
            } // Section
        } // Form
    }
    
    func saveDataToDatabase() {
        let person = DukePerson()
        
        person.firstname = firstname
        person.lastname = lastname
        person.wherefrom = wherefrom
        person.gender = selectedGender
        person.hobbies = hobbies.components(separatedBy: ",")
        person.role = selectedRole
        person.degree = degree
        person.languages = languages.components(separatedBy: ",")
        person.picture = picture
        person.team = team
        person.netid = netid
        person.email = email
        person.picture = imageData ?? ""
        print(imageData ?? "")
        viewModel.add(person: person)
    }
    
    func loadImage() {
        if let image = image {
            let str = image.toString()
            imageData = str
        }
        if let imageUI = image {
            self.image = imageUI
        }
    }
}
