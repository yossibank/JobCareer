import UIKit

enum FontType {
    case system
    case bold
    case italic
}

enum FontSize: CGFloat {

    /** 22 */
    case h1 = 22

    /** 19 */
    case h2 = 19

    /** 16 */
    case h3 = 16

    /** 13 */
    case h4 = 13

    /** 10 */
    case h5 = 10

    /** 0 */
    case none = 0
}

enum BorderWidthSize: CGFloat {

    /** 50.0 */
    case contentImage = 50.0

    /** 4.0 */
    case big = 4.0

    /** 2.0 */
    case midium = 2.0

    /** 1.0 */
    case standard = 1.0

    /** 0 */
    case none = 0.0
}

enum CornerRadiusSize: CGFloat {

    /** 16.0 */
    case bottomSheet = 16.0

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

    /** 0 */
    case none = 0.0
}
