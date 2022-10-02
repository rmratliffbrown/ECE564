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

        _ = self.jpegData(compressionQuality: 1)

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
//    func copy(newSize: CGSize, retina: Bool = true) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(
//            /* size: */ newSize,
//            /* opaque: */ false,
//            /* scale: */ retina ? 0 : 1
//        )
//        defer { UIGraphicsEndImageContext() }
//        self.draw(in: CGRect(origin: .zero, size: newSize))
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

extension UIViewController {
    /// Call within a DispatchQueue.main.async block.
        func presentLoadingSpinner(withMessage message: String, completion: @escaping(_ alert: UIAlertController) -> Void) -> UIAlertController {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            self.present(alert, animated: true) {
                completion(alert)
            }
            
            return alert
        }
}


