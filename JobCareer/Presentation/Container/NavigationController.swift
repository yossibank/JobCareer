import UIKit

final class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setupBackGroundColor(color: .systemBackground)
    }
}

extension UINavigationBar {

    func setupBackGroundColor(color: UIColor) {
        isTranslucent = false

        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = color
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
        } else {
            barTintColor = color
        }
    }
}
