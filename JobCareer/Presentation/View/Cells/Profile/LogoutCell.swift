import Combine
import UIKit

// MARK: - screen transition management
protocol LogoutCellDelegate: AnyObject {
    func showLoginView()
}

// MARK: - stored properties & init

final class LogoutCell: UICollectionViewCell {

    private let logoutButton: AnimationButton = .init(
        style: .cornerStyle,
        title: Resources.Strings.Profile.logout,
        titleColor: Resources.Colors.dynamicColor
    )

    private var cancellables: Set<AnyCancellable> = []

    lazy var buttonTapPublisher: UIControl.Publisher<AnimationButton> = {
        logoutButton.publisher(for: .touchUpInside)
    }()

    weak var delegate: LogoutCellDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()

        buttonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.delegate.showLoginView()
        }
        .store(in: &cancellables)
    }

    @objc func tapped() {
        delegate.showLoginView()
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
