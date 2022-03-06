import FirebaseFirestore

public struct FirestoreManager {
    private static let db = Firestore.firestore()

    static func saveData(
        documentPath: String,
        entity: UserEntity
    ) {
        let data =  UserEntity(
            id: entity.id,
            name: entity.name,
            email: entity.email
        ).toDictionary()

        db.collection(UserEntity.collectionName).document(documentPath).setData(data) { error in
            if let error = error {
                print("failure save data: \(error.localizedDescription)")
            }
        }
    }
}
