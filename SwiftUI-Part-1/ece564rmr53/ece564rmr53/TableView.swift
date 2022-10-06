//
//  TableView.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/1/22.
//

import SwiftUI

struct TableView: View {
    
    // add variable that holds the candidates
    private var people: [DukePerson] = DukePerson.all
    
    // sets up searchbar for future use
    @State private var searchText = ""
    
    // computed values
    var filteredPeople: [DukePerson] = DukePerson.all
    
    var professors: [DukePerson] { filteredPeople.filter { $0.role == Role.Professor.rawValue } }
    var students: [DukePerson] { filteredPeople.filter { $0.role == Role.Student.rawValue } }
    var tas: [DukePerson] { filteredPeople.filter { $0.role == Role.TA.rawValue } }
    var others: [DukePerson] { filteredPeople.filter { $0.role == Role.Other.rawValue } }
    
    var sectioned: [[DukePerson]] { [professors, students, tas, others] }
    
    // another option is printing each role into a section, then looping to fill it
    // I don't really like that I implemented this method, but it works
    
    var body: some View {
        NavigationView{
            List{
                /* Mark: Professor Section - Begin*/
                Section(header: Text("\(Role.Professor.rawValue)")){
                    ForEach(professors, id: \.netid){prof in
                        NavigationLink {ReadOnlyView(person: prof)} label: {
                            HStack{
                                Image(systemName: "person.circle.fill").resizable().scaledToFit().frame(height: 60).foregroundColor(.blue)
                                VStack(alignment: .leading, spacing: 1){
                                    Text(prof.description).lineLimit(4).minimumScaleFactor(0.5).fontWeight(.light)
                                }
                            }
                        }.swipeActions(edge: .leading, allowsFullSwipe: false){
                            Button(action: { print("updateAction")}){
                                Text("Update")
                            }.tint(.green)
                            Button(action: { }){
                                Text("Edit")
                            }.tint(.gray)
                            Button(action: { print("emailAction")}){
                                Image(systemName: "envelope.fill")
                            }.tint(.blue)
                        }.swipeActions(edge: .trailing, allowsFullSwipe: true){
                            Button(action: { print("deleteAction")}){
                                Text("Delete")
                            }.tint(.red)
                        }
                    }
                }
                /* Mark: Student Section - Begin*/
                Section(header: Text("\(Role.Student.rawValue)")){
                    ForEach(students, id: \.netid){stud in
                        NavigationLink {ReadOnlyView(person: stud)} label: {
                            HStack{
                                Image(systemName: "person.circle.fill").resizable().scaledToFit().frame(height: 60).foregroundColor(.blue)
                                VStack(alignment: .leading, spacing: 1){
                                    Text(stud.description).lineLimit(4).minimumScaleFactor(0.5).fontWeight(.light)
                                }
                            }
                        }.swipeActions(edge: .leading, allowsFullSwipe: false){
                            Button(action: { print("updateAction")}){
                                Text("Update")
                            }.tint(.green)
                            Button(action: { }){
                                Text("Edit")
                            }.tint(.gray)
                            Button(action: { print("emailAction")}){
                                Image(systemName: "envelope.fill")
                            }.tint(.blue)
                        }.swipeActions(edge: .trailing, allowsFullSwipe: true){
                            Button(action: { print("deleteAction")}){
                                Text("Delete")
                            }.tint(.red)
                        }
                    }
                }
                /* Mark: TA Section - Begin*/
                Section(header: Text("\(Role.TA.rawValue)")){
                    ForEach(tas, id: \.netid){t in
                        NavigationLink {ReadOnlyView(person: t)} label: {
                            HStack{
                                Image(systemName: "person.circle.fill").resizable().scaledToFit().frame(height: 60).foregroundColor(.blue)
                                VStack(alignment: .leading, spacing: 1){
                                    Text(t.description).lineLimit(4).minimumScaleFactor(0.5).fontWeight(.light)
                                }
                            }
                        }.swipeActions(edge: .leading, allowsFullSwipe: false){
                            Button(action: { print("updateAction")}){
                                Text("Update")
                            }.tint(.green)
                            Button(action: { }){
                                Text("Edit")
                            }.tint(.gray)
                            Button(action: { print("emailAction")}){
                                Image(systemName: "envelope.fill")
                            }.tint(.blue)
                        }.swipeActions(edge: .trailing, allowsFullSwipe: true){
                            Button(action: { print("deleteAction")}){
                                Text("Delete")
                            }.tint(.red)
                        }
                    }
                }
                /* Mark: Other Section - Begin*/
                Section(header: Text("\(Role.Other.rawValue)")){
                    ForEach(others, id: \.netid){oth in
                        NavigationLink {ReadOnlyView(person: oth)} label: {
                            HStack{
                                Image(systemName: "person.circle.fill").resizable().scaledToFit().frame(height: 60).foregroundColor(.blue)
                                VStack(alignment: .leading, spacing: 1){
                                    Text(oth.description).lineLimit(4).minimumScaleFactor(0.5).fontWeight(.light)
                                }
                            }
                        }.swipeActions(edge: .leading, allowsFullSwipe: false){
                            Button(action: { print("updateAction")}){
                                Text("Update")
                            }.tint(.green)
                            Button(action: { }){
                                Text("Edit")
                            }.tint(.gray)
                            Button(action: { print("emailAction")}){
                                Image(systemName: "envelope.fill")
                            }.tint(.blue)
                        }.swipeActions(edge: .trailing, allowsFullSwipe: true){
                            Button(action: { print("deleteAction")}){
                                Text("Delete")
                            }.tint(.red)
                        }
                    }
                }
            }.navigationTitle("Candidates").searchable(text: $searchText).toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    NavigationLink(destination: EditView()) {
                        Button (action: {print("add")}){
                        label: do {Image(systemName: "plus")}
                        }
                    }
                }
            }
        }.listStyle(.insetGrouped) // this removes the dropdown indicator
        
    }
}



struct TableView_Previews: PreviewProvider {
    static var previews: some View {
        TableView()
    }
}




//            List(0 ..< 1) { item in
//                TableViewCell()
//            }.searchable(text: $searchText).navigationTitle("Candidates").toolbar{
//                ToolbarItemGroup(placement: .navigationBarTrailing){
//                    NavigationLink(destination: EditView()) {
//                        Button (action: {print("add")}){
//                        label: do {
//                            Image(systemName: "plus")
//                        }
//                        }
//                    }
//                }
//            }.onTapGesture {
//                isSelected.toggle()
//                print("cell tapped!")
//            }

//    ForEach(eventLogs, id: \.self) { logs in
//              Section(header: Text("\(logs.count)")) {
//                  ForEach(logs) { log in
//                      Text(log.id.description)
//                  }
//              }
//          }

//    ForEach(data.identified(by: \.self)) { array in
//         ForEach(array.identified(by: \.self)) { element in
//             Text("\(element)")
//         }
//     }

//        NavigationView{
//            // list the sections - value
//            List(sectioned, id: \.self){personRole in
//                Section(header: Text("\(personRole.count)")){
//                    // show the individuals in each section
//                    ForEach(personRole, id: \.self){ person in
//                        NavigationLink {ReadOnlyView(person: person)} label: {
//                            // tableview cell - here
//                            HStack{
//                                Image(systemName: "person.circle.fill").resizable().scaledToFit().frame(height: 60).foregroundColor(.blue)
//                                VStack(alignment: .leading, spacing: 1){
//                                    Text(person.description).lineLimit(4).minimumScaleFactor(0.5).fontWeight(.light)
//                                }
//                            }
//                            // tableview cell - here
//                        }.swipeActions(edge: .leading, allowsFullSwipe: false){
//                            Button(action: { print("updateAction")}){
//                                Text("Update")
//                            }.tint(.green)
//                            Button(action: { }){
//                                Text("Edit")
//                            }.tint(.gray)
//                            Button(action: { print("emailAction")}){
//                                Image(systemName: "envelope.fill")
//                            }.tint(.blue)
//                        }.swipeActions(edge: .trailing, allowsFullSwipe: true){
//                            Button(action: { print("deleteAction")}){
//                                Text("Delete")
//                            }.tint(.red)
//                        }
//                    }
//                }.headerProminence(.increased)
//                // makes the cells searchable + navigation title - here
//            }.navigationTitle("Candidates").searchable(text: $searchText).toolbar{
//                ToolbarItemGroup(placement: .navigationBarTrailing){
//                    NavigationLink(destination: EditView()) {
//                        Button (action: {print("add")}){
//                        label: do {Image(systemName: "plus")}
//                        }
//                    }
//                }
//            }
//            // handles removal of the dropdown arrow
//        }.listStyle(.insetGrouped)
