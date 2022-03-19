import UIKit

extension ViewStyle where T: UIButton {

    static var first: ViewStyle<T> {
        ViewStyle<T> {
            $0.setTitle(Resources.Strings.Button.nextTitle, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .random
            $0.layer.cornerRadius = .init(.big)
        }
    }

    static var firstDetail: ViewStyle<T> {
        ViewStyle<T> {
            $0.setTitle(Resources.Strings.Button.backTitle, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .random
            $0.layer.cornerRadius = .init(.big)
        }
    }

    static var second: ViewStyle<T> {
        ViewStyle<T> {
            $0.setTitle(Resources.Strings.Button.cancelButtonTitle, for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .random
            $0.layer.cornerRadius = .init(.big)
        }
    }

    static var signUp: ViewStyle<T> {
        ViewStyle<T> {
            $0.setTitle(Resources.Strings.Button.signUpTitle, for: .normal)
            $0.setTitleColor(Resources.Colors.dynamicColor, for: .normal)
            $0.layer.borderColor = Resources.Colors.borderColor.cgColor
            $0.layer.borderWidth = .init(.standard)
            $0.layer.cornerRadius = .init(.biggest)
        }
    }

    static var goSignUp: ViewStyle<T> {
        ViewStyle<T> {
            $0.setTitle(Resources.Strings.Button.hereIsSignUpTitle, for: .normal)
            $0.setTitleColor(Resources.Colors.dynamicColor, for: .normal)
            $0.titleLabel?.font = .boldSystemFont(ofSize: .init(.h4))
        }
    }

    static var login: ViewStyle<T> {
        ViewStyle<T> {
            $0.setTitle(Resources.Strings.Button.loginTitle, for: .normal)
            $0.setTitleColor(Resources.Colors.dynamicColor, for: .normal)
            $0.layer.borderColor = Resources.Colors.borderColor.cgColor
            $0.layer.borderWidth = .init(.standard)
            $0.layer.cornerRadius = .init(.biggest)
        }
    }

    static var testLogin: ViewStyle<T> {
        ViewStyle<T> {
            $0.setTitle("テストログイン", for: .normal)
            $0.setTitleColor(Resources.Colors.dynamicColor, for: .normal)
            $0.layer.borderColor = Resources.Colors.borderColor.cgColor
            $0.layer.borderWidth = .init(.standard)
            $0.layer.cornerRadius = .init(.biggest)
        }
    }

    static var logout: ViewStyle<T> {
        ViewStyle<T> {
            $0.setTitle(Resources.Strings.Profile.logout, for: .normal)
            $0.setTitleColor(Resources.Colors.dynamicColor, for: .normal)
            $0.layer.borderColor = Resources.Colors.borderColor.cgColor
            $0.layer.borderWidth = .init(.standard)
            $0.layer.cornerRadius = .init(.biggest)
        }
    }

    static var profileNameSave: ViewStyle<T> {
        ViewStyle<T> {
            $0.setTitle("SAVE", for: .normal)
            $0.setTitleColor(Resources.Colors.dynamicColor, for: .normal)
            $0.layer.borderColor = Resources.Colors.borderColor.cgColor
            $0.layer.borderWidth = .init(.standard)
            $0.layer.cornerRadius = .init(.biggest)
        }
    }

    static var bottomSheetDefault: ViewStyle<T> {
        ViewStyle<T> {
            $0.titleLabel?.font = .systemFont(ofSize: FontSize.h2.rawValue)
            $0.backgroundColor = .black
            $0.normalTitleColor = .white
            $0.selectedTitleColor = .white
            $0.disabledTitleColor = .white
            $0.highlightedTitleColor = .white
            $0.focusedTitleColor = .white
            $0.layer.borderColor = Resources.Colors.borderColor.cgColor
            $0.layer.borderWidth = .init(.standard)
        }
    }

    static var bottomSheetCancel: ViewStyle<T> {
        ViewStyle<T> {
            $0.titleLabel?.font = .systemFont(ofSize: .init(.h2))
            $0.backgroundColor = .white
            $0.normalTitleColor = .black
            $0.selectedTitleColor = .black
            $0.disabledTitleColor = .lightGray
            $0.highlightedTitleColor = .black
            $0.focusedTitleColor = .black
            $0.layer.borderColor = Resources.Colors.borderColor.cgColor
            $0.layer.borderWidth = .init(.standard)
        }
    }

    static var bottomSheetAlert: ViewStyle<T> {
        ViewStyle<T> {
            $0.titleLabel?.font = .systemFont(ofSize: .init(.h2))
            $0.backgroundColor = .red
            $0.normalTitleColor = .white
            $0.selectedTitleColor = .white
            $0.disabledTitleColor = .white
            $0.highlightedTitleColor = .white
            $0.focusedTitleColor = .white
            $0.layer.borderColor = Resources.Colors.borderColor.cgColor
            $0.layer.borderWidth = .init(.standard)
        }
    }
}
