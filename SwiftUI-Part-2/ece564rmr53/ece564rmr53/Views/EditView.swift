//
//  EditView.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/2/22.
//

// was working on adding ability to add picture

import SwiftUI
import PhotosUI

// Image upload issue

struct EditView: View {
    
    @StateObject private var viewModel = DataManager.shared
    @Environment(\.dismiss) private var dismiss
    @Binding var person: DukePerson
    
    var body: some View {
        
        NavigationView{
            FormView(person: $person)
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
                            if let selectedImage = person.selectedImage {
                                person.picture = selectedImage
                            }
                            person.hobbies = person.hobbies.first?.components(separatedBy: ", ") ?? [String]()
                            person.languages = person.languages.first?.components(separatedBy: ", ") ?? [String]()
                            viewModel.updatePerson(person: person)
                            
                            if person.netid == "rmr53" {
                                DataManager.shared.updatePerson(person: person, isUpdateOnServer: true)
                            }
                            
                            dismiss()
                        }, label: {
                            Text("Save")
                        })
                        
                    }
                }
        }.onAppear{
            print(person)
        }
    }
}

struct FormView: View{
    
    @Binding var person: DukePerson
    @State private var picture = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var wherefrom = ""
    @State private var hobbies = ""
    @State private var degree = ""
    @State private var department = ""
    @State private var languages = ""
    @State private var team = ""
    @State private var netid = ""
    @State private var email = ""
    @State private var image: UIImage?
    @State private var presentingAlert = false
    @State private var showGallerySheet = false
    @State private var showCameraSheet = false
    
    var roles = Role.allCases
    @State private var selectedRole = "Other"
    
    var genders = Gender.allCases
    @State private var selectedGender = "Other"
    @State private var showImagePicker = false
    
    var body: some View{
        Form {
            HStack(alignment: .top) {
                VStack {
                    VStack {
                        if let imageUI = image {
                            Image(uiImage: imageUI)
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 150, height: 150).foregroundColor(.blue)
                        } else {
                            person.picture.toImage()
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 150, height: 150).foregroundColor(.blue)
                        }
                    }
                    .overlay(alignment: .bottomTrailing) {
                        Image(systemName: "pencil.circle.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.system(size: 30))
                            .foregroundColor(.green)
                    }
                    .onTapGesture {
                        withAnimation(.spring()){
                            self.presentingAlert = true
                        }
                    }
                    Text(firstname + " " + lastname).font(Font.title)
                    Text(selectedRole)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .listRowInsets(EdgeInsets())
            .background(Color(.systemGroupedBackground))
            
            
            Section(header: Text("Information")) {
                Group {
                    Text("\(person.netid)")
                    TextField("First Name", text: $person.firstname)
                    TextField("Last Name", text: $person.lastname)
                    TextField("Email", text: $person.netid)
                        .disabled(true)
                        .onChange(of: netid) { newValue in
                            email = newValue + "@duke.edu"
                        }
                    TextField("Hometown", text: $person.wherefrom)
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(genders, id: \.self) {
                            Text($0.rawValue).tag($0.rawValue)
                        }
                    }
                }
                
                // Group since you can only fit 10 items max
                Group {
                    TextField("Hobbies", text: $hobbies)
                        .onChange(of: hobbies) { value in
                            person.hobbies = [value]
                        }
                    Picker("Role", selection: $selectedRole) {
                        ForEach(roles, id: \.self) {
                            Text($0.rawValue).tag($0.rawValue)
                        }
                    }
                    TextField("Degree", text: $person.degree)
                    TextField("Department", text: $person.department)
                    TextField("Languages", text: $languages)
                        .onChange(of: languages) { value in
                            person.languages = [value]
                        }
                    TextField("Team", text: $person.team)
                }
                
            }
        }
        .onAppear {
            hobbies = person.hobbies.joined(separator: ",")
            languages = person.languages.joined(separator: ",")
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
    }
    
    func loadImage() {
        if let image = image {
            let str = image.toString()
            person.selectedImage = str
        }
        if let imageUI = image {
            self.image = imageUI
        }
    }
}

