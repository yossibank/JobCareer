public struct UserEntity: Equatable {
    public let name: String?
    public let email: String?
    public let iconUrl: String?

    public init(
        name: String?,
        email: String?,
        iconUrl: String?
    ) {
        self.name = name
        self.email = email
        self.iconUrl = iconUrl
    }
}
