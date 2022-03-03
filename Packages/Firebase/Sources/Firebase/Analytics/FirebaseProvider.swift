import FirebaseAnalytics
import Utility

public struct FirebaseProvider: AnalyticsProvider {
    public static var shared: FirebaseProvider = .init()

    private init() {}

    public func sendEvent(title: String) {
        // TODO: please fix
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title)",
            AnalyticsParameterItemName: title,
            AnalyticsParameterContentType: "content"
        ])
    }
}
