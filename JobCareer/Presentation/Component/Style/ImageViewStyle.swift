import UIKit

extension Stylable where Self == UIImageView {

    init(
        style: ViewStyle<Self>,
        image: UIImage
    ) {
        self.init()
        self.image = image
        apply(style)
    }
}

extension ViewStyle where T: UIImageView {

    static var contentImage: ViewStyle<T> {
        ViewStyle<T> {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = BorderWidthSize.contentImage.rawValue
        }
    }
}
