//
//  ReadOnlyView.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/2/22.
//

import SwiftUI


struct ReadOnlyView: View {
    
    @State var person: DukePerson
    
    var body: some View {
        NavigationView{
            VStack {
                HStack(alignment: .top) {
                    VStack {
                        person.picture.toImage()
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 150, height: 150).foregroundColor(.blue)
                        Text("\(person.firstname) \(person.lastname)").font(Font.title)
                        Text("\(person.role)")
                        List {
                            Group{
                                // netid
                                Section {
                                    Text("\(person.netid)")
                                } header: {
                                    Text("NetID")
                                }
                                
                                // email
                                Section {
                                    Text("\(person.email)")
                                } header: {
                                    Text("Email")
                                }
                                
                                // wherefrom
                                
                                Section {
                                    Text("\(person.wherefrom)")
                                } header: {
                                    Text("Hometown")
                                }
                                
                                // gender
                                Section {
                                    Text("\(person.gender)")
                                } header: {
                                    Text("Gender")
                                }
                                
                                // hobbies
                                Section {
                                    Text("\(person.hobbies.joined(separator: ","))")
                                } header: {
                                    Text("Hobbies")
                                }
                                
                                // degree
                                Section {
                                    Text("\(person.degree)")
                                } header: {
                                    Text("Degree")
                                }
                            }
                            
                            Group{
                                // department
                                Section {
                                    Text("\(person.department)")
                                } header: {
                                    Text("Department")
                                }
                                
                                // languages
                                Section {
                                    Text("\(person.languages.joined(separator: ","))")
                                } header: {
                                    Text("Languages")
                                }
                                
                                // team
                                Section {
                                    Text("\(person.team)")
                                } header: {
                                    Text("Team")
                                }
                                // id
                                Section {
                                    Text("\(person.id)")
                                } header: {
                                    Text("ID")
                                }
                                
                                Text("\(person.description)").fontWeight(.light)
                            }
                        }.listStyle(.inset)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets())
                .background(Color(.systemGroupedBackground))
            }   
        }
    }
}

struct ReadOnlyView_Previews: PreviewProvider {
    static var previews: some View {
        ReadOnlyView(person: DukePerson.all[7])
    }
}


////TextField("First Name", text: $firstname)
////TextField("Last Name", text: $lastname)
//Text("Email: ")
//Text("Hometown: ")
////TextField("Gender", text: $gender)
//TextField("Hobbies", text: $hobbies)
////TextField("Role", text: $role)
//TextField("Degree", text: $degree)
//TextField("Languages", text: $languages)
//TextField("Team", text: $team)
