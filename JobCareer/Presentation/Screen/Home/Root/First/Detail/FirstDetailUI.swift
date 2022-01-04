import Combine
import UIKit

// MARK: - stored properties

final class FirstDetailUI {

    private let button: UIButton = .init(
        style: .someStyle,
        title: Resources.Strings.Button.backTitle
    )

    lazy var buttonTapPublisher: UIControl.Publisher<UIButton> = {
        button.publisher(for: .touchUpInside)
    }()
}

// MARK: - protocol

extension FirstDetailUI: UserInterface {

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
