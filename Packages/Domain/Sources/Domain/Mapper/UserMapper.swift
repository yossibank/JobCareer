import Firebase

public struct UserMapper {

    func convert(response: Firebase.UserEntity) -> UserEntity {
        .init(
            name: response.name,
            email: response.email,
            iconUrl: response.iconUrl
        )
    }
}
