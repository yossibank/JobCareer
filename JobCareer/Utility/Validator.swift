import Foundation

protocol ValidationError: Error {}

protocol Validator {
    func validate() -> ValidationResult
}

protocol CompositeValidator: Validator {
    var validators: [Validator] { get }
}

extension CompositeValidator {

    func validate() -> ValidationResult {
        guard let result = validators.map({ $0.validate() }).first(where: { !$0.isValid }) else {
            return .valid
        }

        return result
    }
}

enum ValidationResult {
    case none
    case valid
    case invalid(ValidationError)

    var isValid: Bool {
        switch self {
            case .none:
                return false

            case .valid:
                return true

            case .invalid:
                return false
        }
    }
}

enum EmailValidationError: ValidationError {
    case emtpy
    case regex
}

extension EmailValidationError: LocalizedError {

    var errorDescription: String? {
        switch self {
            case .emtpy:
                return "メールアドレスが入力されていません"

            case .regex:
                return "メールアドレスの形式が正しくありません"
        }
    }
}

enum PasswordValidationError: ValidationError {
    case length
    case unmatch
}

extension PasswordValidationError: LocalizedError {

    var errorDescription: String? {
        switch self {
            case .length:
                return "パスワードは6文字以上でご入力ください"

            case .unmatch:
                return "パスワードが一致しません"
        }
    }
}

struct EmailValidator: Validator {
    let email: String

    func validate() -> ValidationResult {
        if email.isEmpty {
            return .invalid(EmailValidationError.emtpy)
        }

        let regex = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let isRegexValid = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: email)

        guard isRegexValid else {
            return .invalid(EmailValidationError.regex)
        }

        return .valid
    }
}

struct PasswordValidator: Validator {
    let password: String

    func validate() -> ValidationResult {
        if password.count < 6 {
            return .invalid(PasswordValidationError.length)
        }

        return .valid
    }
}

struct ConfirmPasswordValidator: Validator {
    let password: String
    let confirmPassword: String

    func validate() -> ValidationResult {
        if password != confirmPassword {
            return .invalid(PasswordValidationError.unmatch)
        }

        return .valid
    }
}
