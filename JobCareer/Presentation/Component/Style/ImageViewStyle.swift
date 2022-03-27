import UIKit

extension ViewStyle where T: UIImageView {

    static var contentImage: ViewStyle<T> {
        ViewStyle<T> {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = .init(.contentImage)
        }
    }

    static var profileIcon: ViewStyle<T> {
        ViewStyle<T> {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = .init(.profileIcon)
        }
    }
}
