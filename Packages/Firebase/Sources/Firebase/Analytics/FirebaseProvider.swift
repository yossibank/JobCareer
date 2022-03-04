import FirebaseAnalytics
import Utility

public struct FirebaseProvider: AnalyticsProvider {
    public init() {}

    public func sendEvent(title: String) {
        // TODO: please fix
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title)",
            AnalyticsParameterItemName: title,
            AnalyticsParameterContentType: "content"
        ])
    }
}
