import Data
import Firebase

public struct UserMapper {

    func convert(response: UserResponse) -> UserEntity {
        .init(email: response.email)
    }
}
