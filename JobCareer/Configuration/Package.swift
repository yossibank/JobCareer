import Domain
import Firebase
import Utility

struct PackageConfig {

    static func setup() {
        FirebaseConfig.setup()
        DomainConfig.setup(baseURL: API.baseURL)
        UtilityConfig.setup(analytics: FirebaseProvider())
    }
}
