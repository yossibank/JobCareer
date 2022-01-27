import Combine
import Data

public extension UsecaseImpl where R == Repos.Firebase.Auth, M == UserMapper {

    func execute(email: String, password: String) -> AnyPublisher<UserEntity, APIError> {
        toPublisher { promise in
            analytics.sendEvent()

            repository.signUp(email: email, password: password) { result in
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
