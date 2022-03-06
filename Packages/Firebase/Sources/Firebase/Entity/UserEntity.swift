public struct UserEntity: Codable, Equatable {
    public let id: String
    public let name: String?
    public let email: String?

    public func toDictionary() -> [String: Any] {
        [
            "id": id,
            "name": name ?? "",
            "email": email ?? ""
        ]
    }
}

public extension UserEntity {
    static let collectionName = "Users"

    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? ""
        self.name = data["name"] as? String
        self.email = data["email"] as? String
    }
}
