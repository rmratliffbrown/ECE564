//
//  EditView.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/2/22.
//

import SwiftUI

struct EditView: View {
    
    var body: some View {
        NavigationView{
            FormView()
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView()
    }
}

struct FormView: View{
    
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var wherefrom = ""
    @State private var gender = ""
    @State private var hobbies = ""
    @State private var role = ""
    @State private var degree = ""
    @State private var languages = ""
    @State private var team = ""
    @State private var netid = ""
    @State private var email = ""
    //@State private var department = ""
    //@State private var id = ""
    
    var body: some View{
        Form {
            HStack(alignment: .top) {
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150).foregroundColor(.blue)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .listRowInsets(EdgeInsets())
            .background(Color(.systemGroupedBackground))
            
            Section(header: Text("Information")){
                Text("netid")
                TextField("First Name", text: $firstname)
                TextField("Last Name", text: $lastname)
                TextField("Email", text: $email)
                TextField("Hometown", text: $wherefrom)
                //TextField("Gender", text: $gender)
                TextField("Hobbies", text: $hobbies)
                //TextField("Role", text: $role)
                TextField("Degree", text: $degree)
                TextField("Languages", text: $languages)
                TextField("Team", text: $team)
            }
        }
    }
}
