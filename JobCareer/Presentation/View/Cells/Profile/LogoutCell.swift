import Combine
import UIKit

// MARK: - stored properties & init

final class LogoutCell: UICollectionViewCell {

    private let logoutButton: UIButton = .init(
        style: .maskToBounds,
        title: Resources.Strings.Profile.logout,
        titleColor: Resources.Colors.dynamicColor
    )

    lazy var buttonTapPublisher: UIControl.Publisher<UIButton> = {
        logoutButton.publisher(for: .touchUpInside)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - private methods

private extension LogoutCell {

    func setupView() {
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.random.cgColor
        contentView.layer.cornerRadius = 8.0

        contentView.addSubViews(
            logoutButton,

            constraints:
            logoutButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            logoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        )
    }
}
