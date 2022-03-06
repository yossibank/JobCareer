import Firebase

public struct Repos {

    public struct Sample {
        public typealias Get = Repository<SampleGetRequest>
        public typealias Post = Repository<SamplePostRequest>
        public typealias Put = Repository<SamplePutRequest>
        public typealias Delete = Repository<SampleDeleteRequest>
    }

    public struct FirebaseAuth {
        public typealias Login = AuthManager
        public typealias Logout = AuthManager
        public typealias SignUp = AuthManager
    }

    public struct Firestore {
        public typealias Save = Firestore
    }

    public struct Onboarding {
        public typealias GetIsFinished = Repository<GetOnboardingFinishedRequest>
        public typealias SetIsFinished = Repository<SetOnboardingFinishedRequest>
    }
}
