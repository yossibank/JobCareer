import UIKit

// MARK: - override methods

final class BottomBorderTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        addBorder()
    }
}

// MARK: - private methods

private extension BottomBorderTextField {

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
