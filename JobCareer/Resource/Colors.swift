import UIKit

struct ColorResources {
    static let sampleColor: UIColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    static let borderBottomColor: UIColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
    static let borderColor: UIColor = .dynamicColor(light: .black, dark: .lightGray)
    static let staticColor: UIColor = .dynamicColor(light: .white, dark: .black)
    static let dynamicColor: UIColor = .dynamicColor(light: .black, dark: .white)
}

extension UIColor {

    static var random: UIColor {
        let red = CGFloat.random(in: 0...255) / 255.0
        let blue = CGFloat.random(in: 0...255) / 255.0
        let green = CGFloat.random(in: 0...255) / 255.0

        return UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1.0
        )
    }

    static func dynamicColor(
        light: UIColor,
        dark: UIColor
    ) -> UIColor {
        .init { traitCollection -> UIColor in
            traitCollection.userInterfaceStyle == .light
                ? light
                : dark
        }
    }
}
