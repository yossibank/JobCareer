import Combine
import UIKit

// MARK: - stored properties

final class FirstDetailUI {
    private let homeButton: UIButton = .init(
        style: .firstDetail
    )

    lazy var homeButtonTapPublisher: UIControl.Publisher<UIButton> = {
        homeButton.publisher(for: .touchUpInside)
    }()
}

// MARK: - protocol

extension FirstDetailUI: UserInterface {

    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            homeButton,

            constraints:
            homeButton.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            homeButton.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            homeButton.widthAnchor.constraint(equalToConstant: 100),
            homeButton.heightAnchor.constraint(equalToConstant: 100)
        )
    }
}
