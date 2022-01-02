enum HomeSection: CaseIterable, CustomStringConvertible {
    case news
    case contents

    var description: String {
        switch self {
            case .news:
                return "ニュース"

            case .contents:
                return "コンテンツ"
        }
    }

    var initialItems: [HomeItem] {
        switch self {
            case .news:
                return [
                    .init(title: "news1", description: "news1 description"),
                    .init(title: "news2", description: "news2 description"),
                    .init(title: "news3", description: "news3 description"),
                    .init(title: "news4", description: "news4 description"),
                    .init(title: "news5", description: "news5 description"),
                    .init(title: "news6", description: "news6 description")
                ]

            case .contents:
                return [
                    .init(title: "contents1", description: "contents1 description"),
                    .init(title: "contents2", description: "contents2 description"),
                    .init(title: "contents3", description: "contents3 description"),
                    .init(title: "contents4", description: "contents4 description"),
                    .init(title: "contents5", description: "contents5 description"),
                    .init(title: "contents6", description: "contents6 description")
                ]
        }
    }
}

struct HomeItem: Hashable {
    let title: String
    let description: String?
}
