

import UIKit

extension UIImage {
    
    func toString() -> String? {
        let pngData = self.pngData()
        _ = self.jpegData(compressionQuality: 0.5)
        return pngData?.base64EncodedString()
    }
}
