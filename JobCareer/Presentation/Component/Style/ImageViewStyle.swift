import UIKit

extension ViewStyle where T: UIImageView {

    static var contentImage: ViewStyle<T> {
        ViewStyle<T> {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 50
        }
    }
}