import Combine
import Domain
import Utility

final class ProfileViewModel: ViewModel {

    typealias State = LoadingState<EmptyEntity, AppError>

    @Published private(set) var state: State = .standby

    private var cancellables: Set<AnyCancellable> = []

    private let usecase: LogoutUsecase

    init(usecase: LogoutUsecase = Domain.Usecase.Logout()) {
        self.usecase = usecase
    }
}

// MARK: - internal methods

extension ProfileViewModel {

    func logout() {
        state = .loading

        usecase.logout()
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
