import UIKit

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
                return Resources.Strings.Profile.logout
        }
    }

    var items: [ProfileItem] {
        switch self {
            case .main:
                return Main.component

            case .career:
                return Career.component

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

struct Main: Hashable {
    let name: String
    let icon: UIImage

    static var component: [ProfileItem] {
        [.main(.init(name: "TEST1", icon: Resources.Images.Test.testIcon))]
    }
}

struct Career: Hashable {
    let title: String
    let description: String

    static var component: [ProfileItem] {
        [
            .career(.init(title: "CAREER1", description: "career description")),
            .career(.init(title: "CAREER2", description: "career description"))
        ]
    }
}
