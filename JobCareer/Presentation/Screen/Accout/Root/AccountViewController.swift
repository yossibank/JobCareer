import UIKit

extension AccountViewController: VCInjectable {
    typealias VM = AccountViewModel
    typealias UI = AccountUI
}

// MARK: - stored properties

final class AccountViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
}

// MARK: - override methods

extension AccountViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
    }
}
