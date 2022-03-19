import UIKit

extension ViewStyle where T: UITextField {

    static var debug: ViewStyle<T> {
        ViewStyle<T> {
            $0.placeholder = "DISPLAY NAME"
            $0.font = .boldSystemFont(ofSize: .init(.h4))
        }
    }

    static var email: ViewStyle<T> {
        ViewStyle<T> {
            $0.placeholder = Resources.Strings.TextField.emailPlaceholder
            $0.font = .boldSystemFont(ofSize: .init(.h4))
            $0.textAlignment = .left
            $0.clearButtonMode = .unlessEditing
            $0.textContentType = .emailAddress
            $0.keyboardType = .emailAddress
        }
    }

    static var password: ViewStyle<T> {
        ViewStyle<T> {
            $0.placeholder = Resources.Strings.TextField.passwordPlaceholder
            $0.font = .boldSystemFont(ofSize: .init(.h4))
            $0.textAlignment = .left
            $0.clearButtonMode = .unlessEditing
            $0.textContentType = .password
            $0.isSecureTextEntry = true
        }
    }

    static var confirmPassword: ViewStyle<T> {
        ViewStyle<T> {
            $0.placeholder = Resources.Strings.TextField.confirmPasswordPlaceholder
            $0.font = .boldSystemFont(ofSize: .init(.h4))
            $0.textAlignment = .left
            $0.clearButtonMode = .unlessEditing
            $0.textContentType = .newPassword
            $0.isSecureTextEntry = true
        }
    }
}
