import FirebaseFirestore

public struct FirestoreManager {
    private let db = Firestore.firestore()

    public init() {}

    public func save(
        displayName: String?,
        completion: @escaping (Result<UserEntity, Error>) -> Void
    ) {
        guard let user = AuthManager.currentUser else {
            return
        }

        let entity = UserEntity(
            name: displayName,
            email: user.email
        )

        db.collection(UserEntity.collectionName)
            .document(user.uid)
            .setData(entity.toDictionary()) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                completion(.success(entity))
            }
    }
}
