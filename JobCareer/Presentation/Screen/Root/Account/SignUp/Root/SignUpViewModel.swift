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

    private let authUsecase: AuthUsecase
    private let storageUsecase: StorageUsecase
    private let storeUsecase: StoreUsecase

    private var cancellables: Set<AnyCancellable> = []

    init(
        authUsecase: AuthUsecase = Domain.Usecase.Auth(),
        storageUsecase: StorageUsecase = Domain.Usecase.Storage(),
        storeUsecase: StoreUsecase = Domain.Usecase.Store()
    ) {
        self.authUsecase = authUsecase
        self.storageUsecase = storageUsecase
        self.storeUsecase = storeUsecase
    }
}

// MARK: - internal methods

extension SignUpViewModel {

    func signUp() {
        state = .loading

        authUsecase.signUp(email: email, password: password)
            .sink { [weak self] completion in
                switch completion {
                    case let .failure(error):
                        self?.state = .failed(.init(error: error))
                        Logger.debug(message: error.localizedDescription)

                    case .finished:
                        self?.saveStorage()
                        Logger.debug(message: "finished")
                }
            } receiveValue: { [weak self] state in
                self?.state = .done(state)
            }
            .store(in: &cancellables)
    }
}

// MARK: - private methods

private extension SignUpViewModel {

    func saveStorage() {
        guard let data = Resources.Images.Icon.default.jpegData(compressionQuality: 0.3) else {
            return
        }

        storageUsecase.save(data: data)
            .sink { [weak self] completion in
                switch completion {
                    case let .failure(error):
                        Logger.debug(message: error.localizedDescription)

                    case .finished:
                        self?.fetchStorage()
                        Logger.debug(message: "finished")
                }
            } receiveValue: { state in
                Logger.debug(message: "receive value: \(state)")
            }
            .store(in: &cancellables)
    }

    func fetchStorage() {
        storageUsecase.fetch()
            .sink { completion in
                switch completion {
                    case let .failure(error):
                        Logger.debug(message: error.localizedDescription)

                    case .finished:
                        Logger.debug(message: "finished")
                }
            } receiveValue: { [weak self] url in
                self?.saveStore(urlString: url.absoluteString)
            }
            .store(in: &cancellables)
    }

    func saveStore(urlString: String) {
        storeUsecase.save(displayName: nil, iconUrl: urlString)
            .sink { completion in
                switch completion {
                    case let .failure(error):
                        Logger.debug(message: error.localizedDescription)

                    case .finished:
                        Logger.debug(message: "finished")
                }
            } receiveValue: { state in
                Logger.debug(message: "receive value: \(state)")
            }
            .store(in: &cancellables)
    }
}
