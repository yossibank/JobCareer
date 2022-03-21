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

    var items: [HomeItem] {
        switch self {
            case .news:
                return News.component

            case .contents:
                return Contents.component
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

    static var component: [HomeItem] {
        [
            .news(.init(title: "news1", description: "description1")),
            .news(.init(title: "news2", description: "description2")),
            .news(.init(title: "news3", description: "description3")),
            .news(.init(title: "news4", description: "description4")),
            .news(.init(title: "news5", description: "description5")),
            .news(.init(title: "news6", description: "description6"))
        ]
    }
}

struct Contents: Hashable {
    let image: UIImage?
    let description: String

    static var component: [HomeItem] {
        [
            .contents(.init(image: Resources.Images.Test.testIcon, description: "content1")),
            .contents(.init(image: Resources.Images.Test.testIcon, description: "content2")),
            .contents(.init(image: Resources.Images.Test.testIcon, description: "content3")),
            .contents(.init(image: Resources.Images.Test.testIcon, description: "content4")),
            .contents(.init(image: Resources.Images.Test.testIcon, description: "content5")),
            .contents(.init(image: Resources.Images.Test.testIcon, description: "content6"))
        ]
    }
}
