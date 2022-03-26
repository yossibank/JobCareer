import FirebaseStorage

public struct StorageManager {
    private let reference = Storage.storage().reference()

    private let metaData: StorageMetadata = {
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        return metaData
    }()

    public init() {}

    public func save(
        data: Data,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let user = AuthManager.currentUser else {
            return
        }

        reference
            .child(UserEntity.collectionName)
            .child(user.uid)
            .putData(data, metadata: metaData) { _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(()))
            }
    }

    public func fetch(completion: @escaping (Result<URL, Error>) -> Void) {
        guard let user = AuthManager.currentUser else {
            return
        }

        reference
            .child(UserEntity.collectionName)
            .child(user.uid)
            .downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                if let url = url {
                    completion(.success(url))
                }
            }
    }
}
