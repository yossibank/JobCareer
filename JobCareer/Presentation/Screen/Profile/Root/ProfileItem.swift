enum ProfileSection: CaseIterable, CustomStringConvertible {
    case main
    case career
    case logout

    var description: String {
        switch self {
            case .main:
                return Resources.Strings.Profile.profile

            case .career:
                return Resources.Strings.Profile.career

            case .logout:
                return "ログアウト"
        }
    }

    var initialItems: [ProfileItem] {
        switch self {
            case .main:
                return [.main(.init(name: "TEST1", icon: Resources.Images.Test.testIcon))]

            case .career:
                return [
                    .career(.init(title: "CAREER1", description: "career description")),
                    .career(.init(title: "CAREER2", description: "career description"))
                ]

            case .logout:
                return [.logout]
        }
    }
}

enum ProfileItem: Hashable {
    case main(Main)
    case career(Career)
    case logout
}
