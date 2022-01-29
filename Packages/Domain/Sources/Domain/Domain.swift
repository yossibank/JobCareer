import Data

public struct EmptyRepository {}

public typealias FetchSampleUsecase = UsecaseImpl<Repos.Sample.Get, SampleMapper>
public typealias SignUpUsecase = UsecaseImpl<Repos.Firebase.Auth, UserMapper>

public struct Domain {

    public struct Usecase {

        public static func FetchSample(useTestData: Bool = false) -> FetchSampleUsecase {
            .init(
                repository: Repos.Sample.Get(),
                mapper: SampleMapper(),
                useTestData: useTestData
            )
        }

        public static func SignUp() -> SignUpUsecase {
            .init(
                repository: Repos.Firebase.Auth(),
                mapper: UserMapper()
            )
        }
    }
}
