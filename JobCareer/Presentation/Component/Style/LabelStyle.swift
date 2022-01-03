import UIKit

enum FontType {
    case system
    case bold
    case italic
}

enum FontSize: CGFloat {
    case h1 = 22
    case h2 = 19
    case h3 = 16
    case h4 = 13
    case h5 = 10
}

extension Stylable where Self == UILabel {

    init(styles: [ViewStyle<Self>]) {
        self.init()
        styles.forEach { apply($0) }
    }

    init(
        styles: [ViewStyle<Self>],
        fontType: FontType,
        fontSize: FontSize
    ) {
        self.init()

        switch fontType {
            case .system:
                self.font = .systemFont(ofSize: fontSize.rawValue)

            case .bold:
                self.font = .boldSystemFont(ofSize: fontSize.rawValue)

            case .italic:
                self.font = .italicSystemFont(ofSize: fontSize.rawValue)
        }

        styles.forEach { apply($0) }
    }
}



extension ViewStyle where T: UILabel {

    static var centerAlignment: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .center
        }
    }

    static var leftAlignment: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .left
        }
    }

    static var rightAlignment: ViewStyle<T> {
        ViewStyle<T> {
            $0.textAlignment = .right
        }
    }
}
