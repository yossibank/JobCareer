import UIKit

extension Stylable where Self == UILabel {

    init(style: ViewStyle<Self>) {
        self.init()
        apply(style)
    }
}

extension ViewStyle where T: UILabel {

    static var input: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .left
            $0.font = .boldSystemFont(ofSize: .init(.h5))
        }
    }

    static var collectionViewHeader: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .left
            $0.font = .boldSystemFont(ofSize: .init(.h1))
        }
    }

    static var newsTitle: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .center
            $0.font = .boldSystemFont(ofSize: .init(.h1))
        }
    }

    static var newsDescription: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: .init(.h3))
        }
    }

    static var contentDescription: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .left
            $0.numberOfLines = 5
            $0.font = .italicSystemFont(ofSize: .init(.h3))
        }
    }

    static var profileName: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .left
            $0.font = .boldSystemFont(ofSize: .init(.h2))
        }
    }

    static var careerTitle: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: .init(.h3))
        }
    }

    static var carrerDescription: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: .init(.h3))
        }
    }

    static var themeTitle: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .left
            $0.font = .italicSystemFont(ofSize: .init(.h2))
        }
    }

    static var profileTitle: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .left
            $0.font = .italicSystemFont(ofSize: .init(.h2))
        }
    }

    static var bottomSheetTitle: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.font = .boldSystemFont(ofSize: .init(.h1))
        }
    }

    static var bottomSheetBody: ViewStyle<T> {
        ViewStyle<T> {
            $0.numberOfLines = 0
            $0.font = .italicSystemFont(ofSize: .init(.h2))
        }
    }
}
