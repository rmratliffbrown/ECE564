//
//  TableView.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/1/22.
//

import SwiftUI
import Metal

// MARK: need to finish handling optionals to show core data values
// View - UI
// Model - data point
// ViewModel - manages the data for a view

// MARK: Context View

struct ContentView: View {
    
    /// This is now your source of data for your LIst.
    @ObservedObject var viewModel = DataManager.shared
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: Modal Variables
    @State var showAddModalView: Bool = false
    @State var showEditModalView: Bool = false
    @State var active: Bool = true
    @State private var isLoading = false
    @State private var selectedPerson: DukePerson = DukePerson()
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var lastUpdateTime: String = ""
    
    // MARK: Variables for Dynamic Progress
    @State var sampleProgress: CGFloat = 0
    
    // MARK: THIS IS FOR TESTING TO MOVE TO MAIN
    var body: some View {
        // MARK: show the Core Data - MOST RECENT
        LoadingView(isShowing: $viewModel.isLoading) {
            NavigationView {
                List {
                    ForEach(viewModel.peopleListData, id: \.role) { data in
                        Section(data.role) {
                            ForEach(data.dukeTeams, id: \.id) { dukeTeam in
                                if dukeTeam.teamName == "N/A" || dukeTeam.teamName == "NA" || dukeTeam.teamName.isEmpty {
                                    ForEach (dukeTeam.teams) { person in
                                        itemView(person: person)
                                    }
                                } else {
                                    DisclosureGroup(content: {
                                        ForEach (dukeTeam.teams) { person in
                                            itemView(person: person)
                                        }
                                    }, label: {
                                        Text(dukeTeam.teamName)
                                    })
                                }
                            } // ForEach
                        } // Section
                    } // ForEach
                } // List
                .navigationBarItems(
                    trailing: Button(action: {
                        showAddModalView.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                )
                .fullScreenCover(isPresented: $showAddModalView, content: {
                    AddView()
                })
                .onReceive(timer, perform: { _ in
                    lastUpdateTime = viewModel.getLastUpdateTime()
                })
                .toolbar(content: toolbarContent)
                .listStyle(.insetGrouped)
                .searchable(text: $viewModel.searchQuery)
                .navigationTitle("Candidates")
            } // NavigationView
        }
    }
    
    func itemView(person: DukePerson) -> some View {
        NavigationLink(destination: {
            ReadOnlyView(person: person)
        }, label: {
            CellView(picture: person.picture, description: person.description, fullName: person.firstname + " " + person.lastname)
            
        }) // NavigationLink
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
                DataManager.shared.remove(person: person)
            } label: {
                Text("Delete")
            }
            .tint(.red)
        }
        .swipeActions (edge: .leading, allowsFullSwipe: false) {
            Button {
                selectedPerson = person
                showEditModalView.toggle()
            } label: {
                Text("Edit")
            }
            .tint(.blue)
            
//            Button {
//                //selectedPerson = person
//                //DataManager.shared.updatePerson(person: selectedPerson, isUpdateOnServer: true)
//
//            } label: {
//                Text("Update")
//            }
//            .tint(.green)
            
            Button {
                let mailTo = "mailto:\(person.netid)@duke.edu".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let mailtoUrl = URL(string: mailTo!)!
                if UIApplication.shared.canOpenURL(mailtoUrl) {
                    UIApplication.shared.open(mailtoUrl, options: [:])
                }
                print("Send an email to: \(person.netid)@duke.edu")
            } label: {
                Text("Email")
            }
            .tint(.gray)
        }
        .fullScreenCover(isPresented: $showEditModalView, content: {
            EditView(person: $selectedPerson)
        })
    }
}

extension ContentView {
    @ToolbarContentBuilder
    private func toolbarContent() -> some ToolbarContent {
        ToolbarItemGroup(placement: .bottomBar) {
            RefreshButton {
                Task {
                    viewModel.lastDataUpdate = Date()
                    DataManager.shared.refreshData()
                }
            }
            .disabled(isLoading)
            
            Spacer()
            ToolbarStatus(
                isLoading: isLoading,
                lastUpdated: lastUpdateTime,
                quakesCount: viewModel.filteredPeople.count
            )
            .frame(alignment: .center)
            Spacer()
        }
    }
}
