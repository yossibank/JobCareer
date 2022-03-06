import Data

public struct EmptyRepository {}

public typealias FetchSampleUsecase = UsecaseImpl<Repos.Sample.Get, SampleMapper>
public typealias SaveUsecase = UsecaseImpl<Repos.Firestore.Save, UserMapper>
public typealias LoginUsecase = UsecaseImpl<Repos.FirebaseAuth.Login, EmptyMapper>
public typealias LogoutUsecase = UsecaseImpl<Repos.FirebaseAuth.Logout, EmptyMapper>
public typealias SignUpUsecase = UsecaseImpl<Repos.FirebaseAuth.SignUp, EmptyMapper>

public struct Domain {

    public struct Usecase {

        public static func FetchSample(useTestData: Bool = false) -> FetchSampleUsecase {
            .init(
                repository: Repos.Sample.Get(),
                mapper: SampleMapper(),
                useTestData: useTestData
            )
        }

        public static func Save() -> SaveUsecase {
            .init(
                repository: Repos.Firestore.Save(),
                mapper: UserMapper()
            )
        }

        public static func Login() -> LoginUsecase {
            .init(
                repository: Repos.FirebaseAuth.Login(),
                mapper: EmptyMapper()
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
                mapper: EmptyMapper()
            )
        }
    }
}
