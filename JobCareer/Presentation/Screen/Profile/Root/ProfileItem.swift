enum ProfileSection: CaseIterable, CustomStringConvertible {
    case main
    case career

    var description: String {
        switch self {
            case .main:
                return "プロフィール"

            case .career:
                return "経歴"
        }
    }

    var initialItems: [ProfileItem] {
        switch self {
            case .main:
                return [.main("MAIN1")]

            case .career:
                return [
                    .career("CAREER1"),
                    .career("CAREER2")
                ]
        }
    }
}

enum ProfileItem: Hashable {
    case main(String)
    case career(String)
}
