import UIKit

struct ViewStyle<T> {
    let style: (T) -> Void
}

extension ViewStyle {

    func compose(with style: ViewStyle<T>) -> ViewStyle<T> {
        ViewStyle<T> {
            self.style($0)
            style.style($0)
        }
    }
}

protocol Stylable {
    init()
}

extension UIView: Stylable {}

extension Stylable {

    init(style: ViewStyle<Self>) {
        self.init()
        apply(style)
    }

    init(styles: [ViewStyle<Self>]) {
        self.init()
        styles.forEach { apply($0) }
    }

    func apply(_ style: ViewStyle<Self>) {
        style.style(self)
    }
}
