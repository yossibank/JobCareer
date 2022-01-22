import Combine
import UIKit

// MARK: - stored properties

final class FirstUI {

    private let firstDetailbutton: UIButton = .init(
        style: .someStyle,
        title: Resources.Strings.Button.nextTitle
    )

    private let someSwitch: UISwitch = .init()

    lazy var firstDetailButtonTapPublisher: UIControl.Publisher<UIButton> = {
        firstDetailbutton.publisher(for: .touchUpInside)
    }()

    lazy var someSwitchPublisher: AnyPublisher<Bool, Never> = {
        someSwitch.isOnPublisher
    }()
}

// MARK: - protocol

extension FirstUI: UserInterface {

    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            firstDetailbutton,
            someSwitch,

            constraints:
            firstDetailbutton.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            firstDetailbutton.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            firstDetailbutton.widthAnchor.constraint(equalToConstant: 100),
            firstDetailbutton.heightAnchor.constraint(equalToConstant: 100),

            someSwitch.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            someSwitch.topAnchor.constraint(equalTo: firstDetailbutton.bottomAnchor, constant: 10)
        )
    }
}
