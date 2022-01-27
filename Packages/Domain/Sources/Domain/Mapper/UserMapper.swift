import Data

public struct UserMapper {

    func convert(response: UserResponse) -> UserEntity {
        .init(email: response.email)
    }
}
