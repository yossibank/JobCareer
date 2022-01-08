import UIKit

// MARK: - stored properties

final class ProfileUI {

    private let button: UIButton = .init(
        style: .someStyle,
        title: "テスト"
    )
}

// MARK: - protocol

extension ProfileUI: UserInterface {

    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            button,

            constraints:
            button.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 100)
        )
    }
}
