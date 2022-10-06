//
//  ReadOnlyView.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/2/22.
//

import SwiftUI


struct ReadOnlyView: View {
    
    var person: DukePerson
    
    var body: some View {
        NavigationView{
            VStack {
                HStack(alignment: .top) {
                    VStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 150, height: 150).foregroundColor(.blue)
                        Text("\(person.firstname) \(person.lastname)").font(Font.title)
                        Text("\(person.role)")
                        List{
                            // netid
                            Section {
                                Text("\(person.netid)")
                            } header: {
                                Text("NetID").foregroundColor(.red)
                            }
                            
                            // email
                            Section {
                                Text("\(person.email)")
                            } header: {
                                Text("Email").foregroundColor(.orange)
                            }
                            
                            // wherefrom
                            
                            Section {
                                Text("\(person.wherefrom)")
                            } header: {
                                Text("Hometown").foregroundColor(.yellow)
                            }
                            
                            // gender
                            Section {
                                Text("\(person.gender)")
                            } header: {
                                Text("Gender").foregroundColor(.green)
                            }
                            
                            // hobbies
                            Section {
                                Text("\(person.hobbies.joined(separator: ","))")
                            } header: {
                                Text("Hobbies").foregroundColor(.blue)
                            }
                            
                            // degree
                            Section {
                                Text("\(person.degree)")
                            } header: {
                                Text("Degree").foregroundColor(.purple)
                            }
                            
                            // languages
                            Section {
                                Text("\(person.languages.joined(separator: ","))")
                            } header: {
                                Text("Languages").foregroundColor(.red)
                            }
                            
                            // team
                            Section {
                                Text("\(person.team)")
                            } header: {
                                Text("Team").foregroundColor(.orange)
                            }
                            // id
                            Section {
                                Text("\(person.id)")
                            } header: {
                                Text("ID").foregroundColor(.yellow)
                            }
                            
                        }.listStyle(.inset)
                        
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets())
                .background(Color(.systemGroupedBackground))
            }
            //            }.navigationTitle("").toolbar{
            //                ToolbarItemGroup(placement: .navigationBarLeading){
            //                    Button (action: {print("cancel")}){
            //                    label: do {
            //                        Image(systemName: "multiply")
            //                    }
            //                    }
            //                }
            //            }
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
