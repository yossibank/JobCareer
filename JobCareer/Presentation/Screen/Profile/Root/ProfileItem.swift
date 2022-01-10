enum ProfileSection: CaseIterable, CustomStringConvertible {
    case main
    case career

    var description: String {
        switch self {
            case .main:
                return Resources.Strings.Profile.profile

            case .career:
                return Resources.Strings.Profile.career
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
        }
    }
}

enum ProfileItem: Hashable {
    case main(Main)
    case career(Career)
}
