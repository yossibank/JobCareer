import UIKit

extension Stylable where Self == UIView {

    init(style: ViewStyle<Self>) {
        self.init()
        apply(style)
    }
}

extension ViewStyle where T: UIView {

    static var bottomSheet: ViewStyle<T> {
        ViewStyle<T> {
            $0.backgroundColor = .systemBackground
            $0.clipsToBounds = true
            $0.layer.cornerRadius = .init(.bottomSheet)
        }
    }
}
