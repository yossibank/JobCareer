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
}

enum ProfileItem: Hashable {
    case main(Main?)
    case career(Career)
    case logout
}

struct Main: Hashable {
    let name: String
    let icon: UIImage
}

struct Career: Hashable {
    let title: String
    let description: String
}
