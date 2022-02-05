import Combine
import Data

public extension UsecaseImpl where R == Repos.FirebaseAuth.Logout, M == EmptyMapper {

    func logout() -> AnyPublisher<EmptyEntity, APIError> {
        toPublisher { promise in
            analytics.sendEvent()

            repository.logout { result in
                switch result {
                    case let .success(response):
                        let entity = mapper.convert(response: response)
                        promise(.success(entity))

                    case let .failure(error):
                        promise(.failure(error))
                }
            }
        }
    }
}
