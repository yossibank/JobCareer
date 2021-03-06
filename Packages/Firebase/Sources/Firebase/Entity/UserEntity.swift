public struct UserEntity: Codable, Equatable {
    public let name: String?
    public let email: String?
    public let iconUrl: String?

    public init(
        name: String? = nil,
        email: String? = nil,
        iconUrl: String? = nil
    ) {
        self.name = name
        self.email = email
        self.iconUrl = iconUrl
    }

    public func toDictionary() -> [String: Any] {
        [
            "name": name ?? "",
            "email": email ?? "",
            "iconUrl": iconUrl ?? ""
        ]
    }
}

public extension UserEntity {
    static let collectionName = "Users"

    init(data: [String: Any]) {
        self.name = data["name"] as? String
        self.email = data["email"] as? String
        self.iconUrl = data["iconUrl"] as? String
    }
}
