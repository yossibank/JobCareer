import UIKit

extension Stylable where Self == UITextField {

    init(
        style: ViewStyle<Self>,
        placeholder: String? = nil
    ) {
        self.init()
        self.placeholder = placeholder
        apply(style)
    }
}

extension ViewStyle where T: UITextField {

    static var emailStyle: ViewStyle<T> {
        ViewStyle<T> {
            $0.font = .boldSystemFont(ofSize: FontSize.h4.rawValue)
            $0.textAlignment = .left
            $0.clearButtonMode = .unlessEditing
            $0.keyboardType = .emailAddress
        }
    }

    static var passwordStyle: ViewStyle<T> {
        ViewStyle<T> {
            $0.font = .boldSystemFont(ofSize: FontSize.h4.rawValue)
            $0.textAlignment = .left
            $0.clearButtonMode = .unlessEditing
            $0.keyboardType = .emailAddress
            $0.isSecureTextEntry = true
        }
    }
}
