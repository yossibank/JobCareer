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
                    .news(.init(title: "news1", description: "description1")),
                    .news(.init(title: "news2", description: "description2")),
                    .news(.init(title: "news3", description: "description3")),
                    .news(.init(title: "news4", description: "description4")),
                    .news(.init(title: "news5", description: "description5")),
                    .news(.init(title: "news6", description: "description6"))
                ]

            case .contents:
                return [
                    .contents(.init(title: "content1")),
                    .contents(.init(title: "content2")),
                    .contents(.init(title: "content3")),
                    .contents(.init(title: "content4")),
                    .contents(.init(title: "content5")),
                    .contents(.init(title: "content6"))
                ]
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
    let title: String
}
