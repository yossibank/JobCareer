import UIKit

extension Stylable where Self == UIView {

    init(
        style: ViewStyle<Self>,
        backgrounColor: UIColor = .systemBackground,
        cornerRadius: CornerRadiusSize = .none
    ) {
        self.init()
        self.backgroundColor = backgrounColor
        self.layer.cornerRadius = cornerRadius.rawValue
        apply(style)
    }
}

extension ViewStyle where T: UIView {

    static var maskToBounds: ViewStyle<T> {
        ViewStyle<T> {
            $0.layer.masksToBounds = true
        }
    }
}
