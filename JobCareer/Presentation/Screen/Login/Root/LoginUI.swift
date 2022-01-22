import Combine
import UIKit

// MARK: - stored properties

final class LoginUI {

    private lazy var stackView: UIStackView = .init(
        subViews: [animationView, outputStackView, loginButton, signUpButton],
        style: .vertical,
        space: 48
    )

    private lazy var outputStackView: UIStackView = .init(
        subViews: [emailTextField, passwordTextField],
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

    private let loginButton: AnimationButton = .init(
        style: .cornerStyle,
        title: Resources.Strings.Button.loginTitle,
        titleColor: Resources.Colors.dynamicColor
    )

    private let signUpButton: AnimationButton = .init(
        title: "新規登録はこちらから",
        titleColor: Resources.Colors.dynamicColor,
        fontType: .bold,
        fontSize: .h4
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
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            signUpButton.heightAnchor.constraint(equalToConstant: 56)
        )
    }
}
