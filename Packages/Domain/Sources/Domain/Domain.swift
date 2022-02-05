import Data

public struct EmptyRepository {}

public typealias FetchSampleUsecase = UsecaseImpl<Repos.Sample.Get, SampleMapper>
public typealias LoginUsecase = UsecaseImpl<Repos.FirebaseAuth.Login, UserMapper>
public typealias LogoutUsecase = UsecaseImpl<Repos.FirebaseAuth.Logout, EmptyMapper>
public typealias SignUpUsecase = UsecaseImpl<Repos.FirebaseAuth.SignUp, UserMapper>

public struct Domain {

    public struct Usecase {

        public static func FetchSample(useTestData: Bool = false) -> FetchSampleUsecase {
            .init(
                repository: Repos.Sample.Get(),
                mapper: SampleMapper(),
                useTestData: useTestData
            )
        }

        public static func Login() -> LoginUsecase {
            .init(
                repository: Repos.FirebaseAuth.Login(),
                mapper: UserMapper()
            )
        }

        public static func Logout() -> LogoutUsecase {
            .init(
                repository: Repos.FirebaseAuth.Logout(),
                mapper: EmptyMapper()
            )
        }

        public static func SignUp() -> SignUpUsecase {
            .init(
                repository: Repos.FirebaseAuth.SignUp(),
                mapper: UserMapper()
            )
        }
    }
}
