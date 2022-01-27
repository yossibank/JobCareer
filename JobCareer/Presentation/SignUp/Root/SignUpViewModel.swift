import Combine
import Domain
import Utility

final class SignUpViewModel: ViewModel {

    typealias State = LoadingState<UserEntity, AppError>

    private var cancellables: Set<AnyCancellable> = []

    private let usecase: SignUpUsecase

    @Published var email: String = .blank
    @Published var password: String = .blank
    @Published var confirmPassword: String = .blank
    @Published private(set) var state: State = .standby

    init(usecase: SignUpUsecase = Domain.Usecase.SignUp()) {
        self.usecase = usecase
    }
}

// MARK: - internal methods

extension SignUpViewModel {

    func signUp() {
        state = .loading

        usecase.execute(email: email, password: password)
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
