import Data

public struct EmptyRepository {}

public typealias FetchSampleUsecase = UsecaseImpl<Repos.Sample.Get, SampleMapper>
public typealias AuthUsecase = UsecaseImpl<Repos.Firebase.Auth, EmptyMapper>
public typealias StorageUsecase = UsecaseImpl<Repos.Firebase.Storage, EmptyMapper>
public typealias StoreUsecase = UsecaseImpl<Repos.Firebase.Store, UserMapper>

public struct Domain {

    public struct Usecase {

        public static func FetchSample(useTestData: Bool = false) -> FetchSampleUsecase {
            .init(
                repository: Repos.Sample.Get(),
                mapper: SampleMapper(),
                useTestData: useTestData
            )
        }

        public static func Auth() -> AuthUsecase {
            .init(
                repository: Repos.Firebase.Auth(),
                mapper: EmptyMapper()
            )
        }

        public static func Storage() -> StorageUsecase {
            .init(
                repository: Repos.Firebase.Storage(),
                mapper: EmptyMapper()
            )
        }

        public static func Store() -> StoreUsecase {
            .init(
                repository: Repos.Firebase.Store(),
                mapper: UserMapper()
            )
        }
    }
}
