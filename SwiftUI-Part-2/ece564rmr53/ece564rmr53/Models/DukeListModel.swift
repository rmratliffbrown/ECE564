//
//  DukeListModel.swift
//  ece564rmr53
//

import Foundation

struct DukeListModel: Hashable, Identifiable {
    var id: String = UUID().uuidString
    var role: String
    var dukeTeams: [DukeTeams]
    
    init() {
        self.role = ""
        self.dukeTeams = []
    }
}

struct DukeTeams: Hashable, Identifiable {
    var id: String = UUID().uuidString
    var teamName: String
    var teams: [DukePerson]
}
