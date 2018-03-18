import Foundation
import UIKit

extension UIImageView {
    func scaleImage() {
        autoresizingMask = [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
        contentMode = UIViewContentMode.scaleAspectFit
        layer.minificationFilter = kCAFilterTrilinear
        clipsToBounds = true
    }
}
