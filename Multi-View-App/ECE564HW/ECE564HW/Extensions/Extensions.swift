//
//  UIImageView.swift
//  ECE564HW
//
//  Created by Rashaad Ratliff-Brown on 9/14/22.
//

import Foundation
import UIKit

extension UIImageView {
    // Round shaped image
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

extension UIImage {
    func toString() -> String? {
        
        let pngData = self.pngData()

        let jpegData = self.jpegData(compressionQuality: 0.75)

        return pngData?.base64EncodedString(options: .lineLength64Characters)
    }
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        // select the default image
        
        return UIImage(systemName: "person.circle.fill")
       
    }
}

public extension UIImage {
    func copy(newSize: CGSize, retina: Bool = true) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            /* size: */ newSize,
            /* opaque: */ false,
            /* scale: */ retina ? 0 : 1
        )
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension TableViewController: DataManagerDelegate {
    func peopleChanged() {
        self.tableView.reloadData()
    }
}



