import UIKit

// MARK: - init

final class BottomBorderTextField: UITextField {

    init(
        style: ViewStyle<BottomBorderTextField>,
        placeholder: String? = nil
    ) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.borderStyle = .none
        apply(style)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - override methods

extension BottomBorderTextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        addBorder()
    }
}

// MARK: - private methods

extension BottomBorderTextField {

    func addBorder() {
        let border = CALayer()

        border.frame = .init(
            x: 0.0,
            y: frame.size.height - 1.0,
            width: frame.size.width,
            height: 1.0
        )
        border.backgroundColor = Resources.Colors.borderBottomColor.cgColor

        layer.addSublayer(border)
        layer.masksToBounds = true
    }
}
