import Firebase

public struct UserMapper {

    func convert(response: Firebase.UserEntity) -> UserEntity {
        .init(
            id: response.id,
            name: response.name,
            email: response.email
        )
    }
}
