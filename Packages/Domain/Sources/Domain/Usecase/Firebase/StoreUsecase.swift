import Combine
import Data
import Firebase

public extension UsecaseImpl where R == Repos.Firebase.Store, M == UserMapper {

    func save(userEntity: Firebase.UserEntity) -> AnyPublisher<UserEntity, APIError> {
        toPublisher { promise in
            analytics.sendEvent()

            repository.save(userEntity: userEntity) { result in
                switch result {
                    case let .success(response):
                        let entity = mapper.convert(response: response)
                        promise(.success(entity))

                    case let .failure(error):
                        promise(.failure(.firebase(error.localizedDescription)))
                }
            }
        }
    }

    func updateName(_ name: String) -> AnyPublisher<EmptyEntity, APIError> {
        toPublisher { promise in
            analytics.sendEvent()

            repository.updateName(name) { result in
                switch result {
                    case .success:
                        promise(.success(.init()))

                    case let .failure(error):
                        promise(.failure(.firebase(error.localizedDescription)))
                }
            }
        }
    }

    func fetch() -> AnyPublisher<UserEntity, APIError> {
        toPublisher { promise in
            analytics.sendEvent()

            repository.fetch { result in
                switch result {
                    case let .success(response):
                        let entity = mapper.convert(response: response)
                        promise(.success(entity))

                    case let .failure(error):
                        promise(.failure(.firebase(error.localizedDescription)))
                }
            }
        }
    }
}
