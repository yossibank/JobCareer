public struct UserEntity: Codable, Equatable {
    public let name: String?
    public let email: String?

    public func toDictionary() -> [String: Any] {
        [
            "name": name ?? "",
            "email": email ?? ""
        ]
    }
}

public extension UserEntity {
    static let collectionName = "Users"

    init(data: [String: Any]) {
        self.name = data["name"] as? String
        self.email = data["email"] as? String
    }
}
