import Foundation
import SwiftUI

extension String {
    
    func toImage() -> Image {
        /// Convert base64-encoded String to UIImage
        guard let stringData = Data(base64Encoded: self, options: .ignoreUnknownCharacters),
              let uiImage = UIImage(data: stringData) else {
            return Image(systemName: "person.circle.fill")
        }
        return Image(uiImage: uiImage)
    }
    
    func toUIImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: [.ignoreUnknownCharacters]) {
            return UIImage(data: data)
        }
        // select the default image
        
        return UIImage(systemName: "person.circle.fill")
    }
}
