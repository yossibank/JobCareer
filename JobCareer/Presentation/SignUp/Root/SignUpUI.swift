import Combine
import UIKit

// MARK: - stored properties

final class SignUpUI {

    enum OutputType {
        case email
        case password
        case confirmPassword
    }

    private lazy var stackView: UIStackView = .init(
        subViews: [animationView, outputStackView, signUpButton],
        style: .vertical,
        space: 48
    )

    private lazy var outputStackView: UIStackView = .init(
        subViews: [emailStackView, passwordStackView, confirmPasswordStackView],
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

    private lazy var confirmPasswordStackView: UIStackView = .init(
        subViews: [confirmPasswordTextField, confirmPasswordValidationLabel],
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

    private let confirmPasswordTextField: BottomBorderTextField = .init(
        style: .confirmPasswordStyle,
        placeholder: Resources.Strings.TextField.confirmPasswordPlaceholder
    )

    private let confirmPasswordValidationLabel: UILabel = .init(
        styles: [.leftAlignment],
        fontType: .bold,
        fontSize: .h5
    )

    private let signUpButton: AnimationButton = .init(
        style: .cornerStyle,
        title: Resources.Strings.Button.signUpTitle,
        titleColor: Resources.Colors.dynamicColor
    )

    var isEnabled: Bool = false {
        didSet {
            signUpButton.alpha = isEnabled ? 1.0 : 0.5
            signUpButton.isEnabled = isEnabled
        }
    }

    lazy var emailTextPublisher: AnyPublisher<String, Never> = {
        emailTextField.textDidChangePublisher
    }()

    lazy var passwordTextPublisher: AnyPublisher<String, Never> = {
        passwordTextField.textDidChangePublisher
    }()

    lazy var confirmPasswordTextPublisher: AnyPublisher<String, Never> = {
        confirmPasswordTextField.textDidChangePublisher
    }()

    lazy var buttonTapPublisher: UIControl.Publisher<AnimationButton> = {
        signUpButton.publisher(for: .touchUpInside)
    }()
}

// MARK: - internal methods

extension SignUpUI {

    func setupTextField(delegate: UITextFieldDelegate) {
        [emailTextField, passwordTextField, confirmPasswordTextField].forEach {
            $0.delegate = delegate
        }
    }

    func setValidationText(text: String, validColor: UIColor, type: OutputType) {
        switch type {
            case .email:
                emailValidationLabel.text = text
                emailValidationLabel.textColor = validColor

            case .password:
                passwordValidationLabel.text = text
                passwordValidationLabel.textColor = validColor

            case .confirmPassword:
                confirmPasswordValidationLabel.text = text
                confirmPasswordValidationLabel.textColor = validColor
        }
    }

    func getSignUpButtonOffsetY(rootView: UIView) -> CGFloat {
        signUpButton.convert(rootView.frame, to: rootView).origin.y
    }
}

// MARK: - protocol

extension SignUpUI: UserInterface {

    func setupView(rootView: UIView) {
        rootView.backgroundColor = Resources.Colors.staticColor

        rootView.addSubViews(
            stackView,

            constraints:
            stackView.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 56),
            stackView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -56),

            animationView.heightAnchor.constraint(equalToConstant: 120),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 48),
            signUpButton.heightAnchor.constraint(equalToConstant: 56)
        )
    }
}
