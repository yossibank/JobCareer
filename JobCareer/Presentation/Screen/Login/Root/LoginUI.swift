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
        subViews: [emailStackView, passwordStackView],
        style: .vertical,
        space: 16
    )

    private lazy var emailStackView: UIStackView = .init(
        subViews: [emailTextField, emailValidationLabel],
        style: .vertical,
        space: 4
    )

    private lazy var passwordStackView: UIStackView = .init(
        subViews: [passwordTextField, passwordValidationLabel],
        style: .vertical,
        space: 4
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

    private let emailValidationLabel: UILabel = .init(
        styles: [.leftAlignment],
        fontType: .bold,
        fontSize: .h5
    )

    private let passwordTextField: BottomBorderTextField = .init(
        style: .passwordStyle,
        placeholder: Resources.Strings.TextField.passwordPlaceholder
    )

    private let passwordValidationLabel: UILabel = .init(
        styles: [.leftAlignment],
        fontType: .bold,
        fontSize: .h5
    )

    private let loginButton: AnimationButton = .init(
        style: .cornerStyle,
        title: Resources.Strings.Button.loginTitle,
        titleColor: Resources.Colors.dynamicColor
    )

    private let signUpButton: AnimationButton = .init(
        title: Resources.Strings.Button.hereIsSignUpTitle,
        titleColor: Resources.Colors.dynamicColor,
        fontType: .bold,
        fontSize: .h4
    )

    var isEnabled: Bool = false {
        didSet {
            loginButton.alpha = isEnabled ? 1.0 : 0.5
            loginButton.isEnabled = isEnabled
        }
    }

    var emailValidation: ValidationResult = .none {
        didSet {
            switch emailValidation {
                case .none:
                    break

                case .valid:
                    emailValidationLabel.text = "OK ✅"
                    emailValidationLabel.textColor = .green

                case let .invalid(error):
                    emailValidationLabel.text = error.localizedDescription
                    emailValidationLabel.textColor = .red
            }
        }
    }

    var passwordValidation: ValidationResult = .none {
        didSet {
            switch passwordValidation {
                case .none:
                    break

                case .valid:
                    passwordValidationLabel.text = "OK ✅"
                    passwordValidationLabel.textColor = .green

                case let .invalid(error):
                    passwordValidationLabel.text = error.localizedDescription
                    passwordValidationLabel.textColor = .red
            }
        }
    }

    lazy var emailTextPublisher: AnyPublisher<String, Never> = {
        emailTextField.textDidChangePublisher
    }()

    lazy var passwordTextPublisher: AnyPublisher<String, Never> = {
        passwordTextField.textDidChangePublisher
    }()

    lazy var loginButtonTapPublisher: UIControl.Publisher<AnimationButton> = {
        loginButton.publisher(for: .touchUpInside)
    }()

    lazy var signUpButtonTapPublisher: UIControl.Publisher<AnimationButton> = {
        signUpButton.publisher(for: .touchUpInside)
    }()
}

// MARK: - internal methods

extension LoginUI {

    func setupTextField(delegate: UITextFieldDelegate) {
        [emailTextField, passwordTextField].forEach {
            $0.delegate = delegate
        }
    }

    func getLoginButtonOffsetY(rootView: UIView) -> CGFloat {
        loginButton.convert(rootView.frame, to: rootView).origin.y
    }
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
