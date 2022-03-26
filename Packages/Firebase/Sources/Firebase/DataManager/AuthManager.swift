import FirebaseAuth

public struct AuthManager {
    public static var currentUser: User? {
        Auth.auth().currentUser
    }

    public init() {}

    public func signUp(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            FirestoreManager().save(displayName: nil) { _ in }
            completion(.success(()))
        }
    }

    public func login(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }

    public func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        guard Auth.auth().currentUser != nil else {
            return
        }

        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    public func withdrawal(
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let user = Auth.auth().currentUser else {
            return
        }

        let credential = EmailAuthProvider.credential(
            withEmail: user.email ?? "",
            password: password
        )

        user.reauthenticate(with: credential) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            user.delete { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                FirestoreManager().delete(completion: completion)
                completion(.success(()))
            }
        }
    }
}
