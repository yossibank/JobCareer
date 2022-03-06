import Domain
import Firebase

enum PackageConfig {
    static func setup() {
        DomainConfig.setup(baseURL: API.baseURL)
        FirebaseConfig.setup(analytics: FirebaseProvider())
    }
}
