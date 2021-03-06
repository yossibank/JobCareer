import UIKit

enum FontSize: CGFloat {
    /** 21 */
    case h1 = 21
    /** 18 */
    case h2 = 18
    /** 15 */
    case h3 = 15
    /** 12 */
    case h4 = 12
    /** 9 */
    case h5 = 9
    /** 0 */
    case none = 0
}

enum ContentSize: CGFloat {
    /** 50.0 */
    case contentImage = 50.0
    /** 16.0 */
    case bottomSheet = 16.0
    /** 12.0 */
    case profileIcon = 12.0
    /** 8.0 */
    case biggest = 8.0
    /** 6.0 */
    case bigger = 6.0
    /** 4.0 */
    case big = 4.0
    /** 2.0 */
    case midium = 2.0
    /** 1.0 */
    case standard = 1.0
    /** 0.0 */
    case none = 0.0
}

extension CGFloat {

    init(_ fontSize: FontSize) {
        self.init(fontSize.rawValue)
    }

    init(_ contentSize: ContentSize) {
        self.init(contentSize.rawValue)
    }
}
