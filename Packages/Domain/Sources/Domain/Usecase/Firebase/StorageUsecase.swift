import Combine
import Data
import Foundation

public extension UsecaseImpl where R == Repos.Firebase.Storage, M == EmptyMapper {

    func save(data: Data) -> AnyPublisher<EmptyEntity, APIError> {
        toPublisher { promise in
            analytics.sendEvent()

            repository.save(data: data) { result in
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
