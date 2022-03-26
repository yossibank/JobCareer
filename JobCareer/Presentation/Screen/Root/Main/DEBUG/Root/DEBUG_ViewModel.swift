#if DEBUG

import Combine
import Domain
import Utility

final class DEBUG_ViewModel: ViewModel {
    typealias State = LoadingState<UserEntity, AppError>

    @Published private(set) var state: State = .standby

    @Published var displayName: String = .blank

    private let authUsecase: FirestoreUsecase

    private var cancellables: Set<AnyCancellable> = []

    init(authUsecase: FirestoreUsecase = Domain.Usecase.Firestore()) {
        self.authUsecase = authUsecase
    }
}

// MARK: - internal methods

extension DEBUG_ViewModel {

    func save() {
        authUsecase.save(displayName: displayName)
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

#endif
