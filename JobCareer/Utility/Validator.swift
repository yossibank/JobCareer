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
        guard
            let result = validators.map({ $0.validate() }).first(where: { !$0.isValid })
        else {
            return .valid
        }

        return result
    }
}

enum ValidationResult {
    case valid
    case invalid(ValidationError)

    var isValid: Bool {
        switch self {
            case .valid:
                return true

            case .invalid:
                return false
        }
    }
}

enum EmailValidationError: ValidationError {
    case emtpy
}

extension EmailValidationError: LocalizedError {

    var errorDescription: String? {
        switch self {
            case .emtpy:
                return "メールアドレスが入力されていません"
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

        return .valid
    }
}

struct PasswordValidator: Validator {
    let password: String
    let confirmPassword: String

    func validate() -> ValidationResult {
        if password.count < 6 {
            return .invalid(PasswordValidationError.length)
        }

        if password != confirmPassword {
            return .invalid(PasswordValidationError.unmatch)
        }

        return .valid
    }
}
