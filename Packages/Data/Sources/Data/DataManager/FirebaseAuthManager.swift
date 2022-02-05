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

    public func login(
        email: String,
        password: String,
        completion: @escaping (Result<User, APIError>) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(.error(error.localizedDescription)))
            }

            if let user = result?.user {
                completion(.success(user))
            }
        }
    }

    public func logout(completion: @escaping (Result<EmptyResponse, APIError>) -> Void) {
        guard let _ = Auth.auth().currentUser else {
            return
        }

        do {
            try Auth.auth().signOut()
            completion(.success(.init()))
        } catch {
            completion(.failure(.error(error.localizedDescription)))
        }
    }
}
