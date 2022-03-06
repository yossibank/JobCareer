import FirebaseCore

public enum FirebaseConfig {
    public static func setup(analytics: AnalyticsProvider) {
        FirebaseApp.configure()
        Analytics.shared.provider = analytics
    }
}
