import Combine
import Lottie
import UIKit

// MARK: - stored properties

final class LoginUI {

    private lazy var stackView: UIStackView = .init(
        subViews: [imageStackView, inputStackView, loginButtonStackView],
        style: .vertical,
        space: 64
    )

    private lazy var imageStackView: UIStackView = .init(
        subViews: [iconImage],
        style: .vertical,
        alignment: .trailing
    )

    private lazy var inputStackView: UIStackView = .init(
        subViews: [emailTextField, passwordTextField, confirmPasswordTextField],
        style: .vertical,
        space: 16
    )

    private lazy var loginButtonStackView: UIStackView = .init(
        subViews: [loginButton],
        style: .vertical
    )

    private let iconImage: UIImageView = .init(
        image: Resources.Images.Test.testIcon
    )

    private let emailTextField: BottomBorderTextField = .init(
        style: .emailStyle,
        placeholder: "メールアドレス"
    )

    private let passwordTextField: BottomBorderTextField = .init(
        style: .passwordStyle,
        placeholder: "パスワード"
    )

    private let confirmPasswordTextField: BottomBorderTextField = .init(
        style: .passwordStyle,
        placeholder: "パスワード(確認)"
    )

    private let loginButton: UIButton = .init(
        style: .someStyle,
        title: Resources.Strings.Button.loginTitle
    )

    lazy var buttonTapPublisher: UIControl.Publisher<UIButton> = {
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

            iconImage.widthAnchor.constraint(equalToConstant: 100),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 48),
            loginButton.heightAnchor.constraint(equalToConstant: 56)
        )
    }
}
