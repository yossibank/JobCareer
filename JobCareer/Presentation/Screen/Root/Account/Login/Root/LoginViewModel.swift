import Combine
import Domain
import Utility

final class LoginViewModel: ViewModel {
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

    var isEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($email, $password)
            .map { email, password in
                let isEmailValid = EmailValidator(email: email).validate().isValid
                let isPasswordValid = PasswordValidator(password: password).validate().isValid
                return isEmailValid && isPasswordValid
            }
            .eraseToAnyPublisher()
    }

    @Published var email: String = .blank
    @Published var password: String = .blank
    @Published private(set) var state: State = .standby

    private let usecase: AuthUsecase

    private var cancellables: Set<AnyCancellable> = []

    init(usecase: AuthUsecase = Domain.Usecase.Auth()) {
        self.usecase = usecase
    }
}

// MARK: - internal methods

extension LoginViewModel {

    func login() {
        state = .loading

        usecase.login(email: email, password: password)
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

    func testLogin() {
        state = .loading

        usecase.login(email: "test@test.com", password: "testtest")
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
