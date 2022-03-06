#if DEBUG

import Combine
import Domain
import Utility

final class DEBUG_ViewModel: ViewModel {
    typealias State = LoadingState<UserEntity, AppError>

    @Published private(set) var state: State = .standby

    @Published var displayName: String = .blank

    private let usecase: SaveUsecase

    private var cancellables: Set<AnyCancellable> = []

    init(usecase: SaveUsecase = Domain.Usecase.Save()) {
        self.usecase = usecase
    }
}

// MARK: - internal methods

extension DEBUG_ViewModel {

    func save() {
        usecase.save(displayName: displayName)
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
