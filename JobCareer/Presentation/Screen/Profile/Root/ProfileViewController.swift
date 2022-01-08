import UIKit

extension ProfileViewController: VCInjectable {
    typealias VM = ProfileViewModel
    typealias UI = ProfileUI
}

// MARK: - stored properties

final class ProfileViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
}

// MARK: - override methods

extension ProfileViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
    }
}
