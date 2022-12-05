//
//  RefreshButton.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 11/21/22.
//

import SwiftUI

struct RefreshButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            Label("Refresh", systemImage: "arrow.clockwise")
        }
    }
}

struct RefreshButton_Previews: PreviewProvider {
    static var previews: some View {
        RefreshButton()
    }
}

