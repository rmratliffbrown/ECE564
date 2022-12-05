//
//  ToolBarStatus.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 11/21/22.
//

import Foundation
import SwiftUI

struct ToolbarStatus: View {
    var isLoading: Bool
    var lastUpdated: String
    var quakesCount: Int

    var body: some View {
        VStack{
            if isLoading {
                Text("Checking for Earthquakes...")
                Spacer()
            } else {
                Text(lastUpdated)
                Text("\(quakesCount) Candidates")
                    .foregroundStyle(Color.accentColor)
            }
        }
        .font(.caption)
    }
}
