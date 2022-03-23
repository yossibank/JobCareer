import UIKit

enum HomeSection: CaseIterable, CustomStringConvertible {
    case news
    case contents

    var description: String {
        switch self {
            case .news:
                return Resources.Strings.Home.news

            case .contents:
                return Resources.Strings.Home.contents
        }
    }
}

enum HomeItem: Hashable {
    case news(News)
    case contents(Contents)
}

struct News: Hashable {
    let title: String
    let description: String?
}

struct Contents: Hashable {
    let image: UIImage?
    let description: String
}
