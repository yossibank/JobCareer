import Firebase

public struct Repos {

    public struct Sample {
        public typealias Get = Repository<SampleGetRequest>
        public typealias Post = Repository<SamplePostRequest>
        public typealias Put = Repository<SamplePutRequest>
        public typealias Delete = Repository<SampleDeleteRequest>
    }

    public struct Firebase {
        public typealias Auth = AuthManager
        public typealias Firestore = FirestoreManager
        public typealias Storage = StorageManager
    }

    public struct Onboarding {
        public typealias GetIsFinished = Repository<GetOnboardingFinishedRequest>
        public typealias SetIsFinished = Repository<SetOnboardingFinishedRequest>
    }
}
