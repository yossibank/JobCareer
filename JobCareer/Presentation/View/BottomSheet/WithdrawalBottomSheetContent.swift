import Combine
import UIKit

// MARK: - stored properties & init

final class WithdrawalBottomSheetContent: UIView {
    private lazy var stackView: UIStackView = .init(
        subViews: [withdrawalTitleLabel, withdrawalPasswordTextField, withdrawalButton],
        style: .vertical,
        distributon: .fill,
        alignment: .fill,
        space: 32
    )

    private let withdrawalTitleLabel: UILabel = .init(
        style: .withdrawalTitle
    )

    private let withdrawalPasswordTextField: BottomBorderTextField = .init(
        style: .withdrawalPassword
    )

    private let withdrawalButton: AnimationButton = .init(
        style: .withdrawal
    )

    var isEnabled: Bool = false {
        didSet {
            withdrawalButton.alpha = isEnabled ? 1.0 : 0.5
            withdrawalButton.isEnabled = isEnabled
        }
    }

    lazy var passwordTextPublisher: AnyPublisher<String, Never> = {
        withdrawalPasswordTextField.textDidChangePublisher
    }()

    lazy var withdrawalButtonTapPublisher: UIControl.Publisher<AnimationButton> = {
        withdrawalButton.publisher(for: .touchUpInside)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - private methods

private extension WithdrawalBottomSheetContent {

    func setupView() {
        backgroundColor = .systemBackground

        addSubViews(
            stackView,

            constraints:
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),

            withdrawalPasswordTextField.heightAnchor.constraint(equalToConstant: 36),
            withdrawalButton.heightAnchor.constraint(equalToConstant: 48)
        )
    }
}
