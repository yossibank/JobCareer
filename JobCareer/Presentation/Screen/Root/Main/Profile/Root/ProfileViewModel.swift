import Combine
import Domain
import Utility

final class ProfileViewModel: ViewModel {
    typealias AuthState = LoadingState<EmptyEntity, AppError>
    typealias FirestoreState = LoadingState<UserEntity, AppError>

    var isEnabled: AnyPublisher<Bool, Never> {
        $passowrd.map { !$0.isEmpty && $0.count >= 6 }.eraseToAnyPublisher()
    }

    @Published var passowrd: String = .blank
    @Published private(set) var authState: AuthState = .standby
    @Published private(set) var firestoreState: FirestoreState = .standby

    private let authUsecase: FirebaseAuthUsecase
    private let firestoreUsecase: FirestoreUsecase

    private var cancellables: Set<AnyCancellable> = []

    init(
        authUsecase: FirebaseAuthUsecase = Domain.Usecase.FirebaseAuth(),
        firestoreUsecase: FirestoreUsecase = Domain.Usecase.Firestore()
    ) {
        self.authUsecase = authUsecase
        self.firestoreUsecase = firestoreUsecase
    }
}

// MARK: - internal methods

extension ProfileViewModel {

    func fetch() {
        firestoreState = .loading

        firestoreUsecase.fetch()
            .sink { [weak self] completion in
                switch completion {
                    case let .failure(error):
                        self?.firestoreState = .failed(.init(error: error))
                        Logger.debug(message: error.localizedDescription)

                    case .finished:
                        Logger.debug(message: "finished")
                }
            } receiveValue: { [weak self] state in
                self?.firestoreState = .done(state)
            }
            .store(in: &cancellables)
    }

    func logout() {
        authState = .loading

        authUsecase.logout()
            .sink { [weak self] completion in
                switch completion {
                    case let .failure(error):
                        self?.authState = .failed(.init(error: error))
                        Logger.debug(message: error.localizedDescription)

                    case .finished:
                        Logger.debug(message: "finished")
                }
            } receiveValue: { [weak self] state in
                self?.authState = .done(state)
            }
            .store(in: &cancellables)
    }

    func withdrawal() {
        authState = .loading

        authUsecase.withdrawal(password: passowrd)
            .sink { [weak self] completion in
                switch completion {
                    case let .failure(error):
                        self?.passowrd = .blank
                        self?.authState = .failed(.init(error: error))
                        Logger.debug(message: error.localizedDescription)

                    case .finished:
                        Logger.debug(message: "finished")
                }
            } receiveValue: { [weak self] state in
                self?.authState = .done(state)
            }
            .store(in: &cancellables)
    }
}
