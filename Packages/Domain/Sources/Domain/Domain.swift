import Data

public struct EmptyRepository {}

public typealias FetchSampleUsecase = UsecaseImpl<Repos.Sample.Get, SampleMapper>
public typealias FirebaseAuthUsecase = UsecaseImpl<Repos.FirebaseAuth, EmptyMapper>
public typealias FirestoreUsecase = UsecaseImpl<Repos.Firestore, UserMapper>

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
                repository: Repos.FirebaseAuth(),
                mapper: EmptyMapper()
            )
        }

        public static func Firestore() -> FirestoreUsecase {
            .init(
                repository: Repos.Firestore(),
                mapper: UserMapper()
            )
        }
    }
}
