import Combine
import Domain
import Utility

final class SignUpViewModel: ViewModel {
    typealias State = LoadingState<EmptyEntity, AppError>

    var emailValidated: AnyPublisher<ValidationResult, Never> {
        $email.map { email in
            EmailValidator(email: email).validate()
        }.eraseToAnyPublisher()
    }

    var passwordValidated: AnyPublisher<ValidationResult, Never> {
        $password.map { password in
            PasswordValidator(password: password).validate()
        }.eraseToAnyPublisher()
    }

    var confirmPasswordValidated: AnyPublisher<ValidationResult, Never> {
        $confirmPassword.combineLatest($password) { password, confirmPassword in
            ConfirmPasswordValidator(password: password, confirmPassword: confirmPassword).validate()
        }.eraseToAnyPublisher()
    }

    var isEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3($email, $password, $confirmPassword)
            .map { email, password, confirmPassword in
                let isEmailValid = EmailValidator(
                    email: email
                ).validate().isValid

                let isPasswordValid = PasswordValidator(
                    password: password
                ).validate().isValid

                let isConfirmPasswordValid = ConfirmPasswordValidator(
                    password: password,
                    confirmPassword: confirmPassword
                ).validate().isValid

                return isEmailValid && isPasswordValid && isConfirmPasswordValid

            }.eraseToAnyPublisher()
    }

    @Published var email: String = .blank
    @Published var password: String = .blank
    @Published var confirmPassword: String = .blank
    @Published private(set) var state: State = .standby

    private let usecase: SignUpUsecase

    private var cancellables: Set<AnyCancellable> = []

    init(usecase: SignUpUsecase = Domain.Usecase.SignUp()) {
        self.usecase = usecase
    }
}

// MARK: - internal methods

extension SignUpViewModel {

    func signUp() {
        state = .loading

        usecase.signUp(email: email, password: password)
            .sink { [weak self] completion in
                switch completion {
                    case let .failure(error):
                        self?.state = .failed(.init(error: error))
                        Logger.debug(message: error.localizedDescription)

                    case .finished:
                        Logger.debug(message: "finished")
                }
            } receiveValue: { [weak self] state in
                self?.state = .done(state)
            }
            .store(in: &cancellables)
    }
}
