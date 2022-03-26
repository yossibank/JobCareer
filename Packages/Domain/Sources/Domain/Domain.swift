import Data

public struct EmptyRepository {}

public typealias FetchSampleUsecase = UsecaseImpl<Repos.Sample.Get, SampleMapper>
public typealias FirebaseAuthUsecase = UsecaseImpl<Repos.Firebase.Auth, EmptyMapper>
public typealias FirestoreUsecase = UsecaseImpl<Repos.Firebase.Firestore, UserMapper>
public typealias FirebaseStorageUsecase = UsecaseImpl<Repos.Firebase.Storage, EmptyMapper>

public struct Domain {

    public struct Usecase {

        public static func FetchSample(useTestData: Bool = false) -> FetchSampleUsecase {
            .init(
                repository: Repos.Sample.Get(),
                mapper: SampleMapper(),
                useTestData: useTestData
            )
        }

        public static func FirebaseAuth() -> FirebaseAuthUsecase {
            .init(
                repository: Repos.Firebase.Auth(),
                mapper: EmptyMapper()
            )
        }

        public static func Firestore() -> FirestoreUsecase {
            .init(
                repository: Repos.Firebase.Firestore(),
                mapper: UserMapper()
            )
        }

        public static func Storage() -> FirebaseStorageUsecase {
            .init(
                repository: Repos.Firebase.Storage(),
                mapper: EmptyMapper()
            )
        }
    }
}
