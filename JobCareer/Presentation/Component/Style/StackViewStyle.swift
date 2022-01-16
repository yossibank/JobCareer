import UIKit

extension Stylable where Self == UIStackView {

    init(
        subViews: [UIView],
        style: ViewStyle<Self>,
        distributon: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        space: CGFloat = 0
    ) {
        self.init()
        subViews.forEach { self.addArrangedSubview($0) }
        self.distribution = distributon
        self.alignment = alignment
        self.spacing = space
        apply(style)
    }
}

extension ViewStyle where T: UIStackView {

    static var horizontal: ViewStyle<T> {
        ViewStyle<T> {
            $0.axis = .horizontal
        }
    }

    static var vertical: ViewStyle<T> {
        ViewStyle<T> {
            $0.axis = .vertical
        }
    }
}
