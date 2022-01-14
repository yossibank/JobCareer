import Combine
import UIKit

// MARK: - stored properties & init

final class LogoutCell: UICollectionViewCell {

    private let logoutButton: AnimationButton = .init(
        style: .cornerStyle,
        title: Resources.Strings.Profile.logout,
        titleColor: Resources.Colors.dynamicColor
    )

    lazy var buttonTapPublisher: UIControl.Publisher<AnimationButton> = {
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
