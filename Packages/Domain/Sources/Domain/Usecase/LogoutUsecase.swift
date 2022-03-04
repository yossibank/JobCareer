import Combine
import Data

public extension UsecaseImpl where R == Repos.FirebaseAuth.Logout, M == EmptyMapper {

    func logout() -> AnyPublisher<EmptyEntity, APIError> {
        toPublisher { promise in
            analytics.sendEvent()

            repository.logout { result in
                switch result {
                    case .success:
                        let entity = mapper.convert()
                        promise(.success(entity))

                    case let .failure(error):
                        promise(.failure(.firebase(error.localizedDescription)))
                }
            }
        }
    }
}
