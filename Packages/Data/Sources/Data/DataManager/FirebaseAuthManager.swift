import FirebaseAuth

public typealias UserResponse = FirebaseAuth.User

public struct FirebaseAuthManager {

    public init() {}

    public func signUp(
        email: String,
        password: String,
        completion: @escaping (Result<User, APIError>) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(.error(error.localizedDescription)))
            }

            if let user = result?.user {
                completion(.success(user))
            }
        }
    }
}
