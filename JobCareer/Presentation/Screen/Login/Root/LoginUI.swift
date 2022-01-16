import Combine
import UIKit

// MARK: - stored properties

final class LoginUI {

    private lazy var stackView: UIStackView = .init(
        subViews: [animationView, outputStackView, loginButton],
        style: .vertical,
        space: 48
    )

    private lazy var outputStackView: UIStackView = .init(
        subViews: [emailTextField, passwordTextField, confirmPasswordTextField],
        style: .vertical,
        space: 16
    )

    private let animationView: UIView = {
        let view = UIView()
        view.setAnimation(animation: .penguin, loopMode: .autoReverse)
        return view
    }()

    private let emailTextField: BottomBorderTextField = .init(
        style: .emailStyle,
        placeholder: Resources.Strings.TextField.emailPlaceholder
    )

    private let passwordTextField: BottomBorderTextField = .init(
        style: .passwordStyle,
        placeholder: Resources.Strings.TextField.passwordPlaceholder
    )

    private let confirmPasswordTextField: BottomBorderTextField = .init(
        style: .passwordStyle,
        placeholder: Resources.Strings.TextField.confirmPasswordPlaceholder
    )

    private let loginButton: AnimationButton = .init(
        style: .cornerStyle,
        title: Resources.Strings.Button.loginTitle,
        titleColor: Resources.Colors.dynamicColor
    )

    lazy var buttonTapPublisher: UIControl.Publisher<AnimationButton> = {
        loginButton.publisher(for: .touchUpInside)
    }()
}

// MARK: - protocol

extension LoginUI: UserInterface {

    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            stackView,

            constraints:
            stackView.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 56),
            stackView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -56),

            animationView.heightAnchor.constraint(equalToConstant: 160),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 48),
            loginButton.heightAnchor.constraint(equalToConstant: 56)
        )
    }
}
