//
//  CellView.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/18/22.
//

import SwiftUI

struct CellView: View {
    
    var picture: String
    var description: String
    var fullName: String
    
    var body: some View {
        HStack {
            if let imageUI = picture.toUIImage() {
                Image(uiImage: imageUI)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                    .foregroundColor(.blue)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 70, height: 70)
                    .foregroundColor(.blue)
            }
            VStack(alignment: .leading, spacing: 1) {
                Text(fullName)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.black.opacity(0.8))
                
                Text(description)
                    .fontWeight(.medium)
                    .lineLimit(4)
                    .minimumScaleFactor(0.5)
                    .foregroundColor(Color.gray)
                    .padding(.top, 5)
            }
            .padding(.leading)
        }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(picture: "", description: "Test", fullName: "Test")
    }
}
