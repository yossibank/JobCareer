import Combine
import UIKit

// MARK: - stored properties & init

final class WithdrawalCell: UICollectionViewCell {
    private let withdrawalButton: AnimationButton = .init(
        style: .withdrawal
    )

    lazy var buttonTapPublisher: UIControl.Publisher<AnimationButton> = {
        withdrawalButton.publisher(for: .touchUpInside)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        withdrawalButton.layer.borderColor = UIColor.red.cgColor
    }
}

// MARK: - private methods

private extension WithdrawalCell {

    func setupView() {
        contentView.addSubViews(
            withdrawalButton,

            constraints:
            withdrawalButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            withdrawalButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            withdrawalButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            withdrawalButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        )
    }
}
