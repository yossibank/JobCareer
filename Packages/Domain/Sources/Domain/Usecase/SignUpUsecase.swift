import Combine
import Data

public extension UsecaseImpl where R == Repos.FirebaseAuth.SignUp, M == EmptyMapper {

    func signUp(email: String, password: String) -> AnyPublisher<EmptyEntity, APIError> {
        toPublisher { promise in
            analytics.sendEvent()

            repository.signUp(email: email, password: password) { result in
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
