import UIKit

// MARK: - stored properties & init

final class ProfileFlowController: UIViewController {
    weak var delegate: MainFlowControllerDelegate!

    private let navVC = NavigationController()

    init() {
        super.init(nibName: nil, bundle: nil)
        add(navVC)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - override methods

extension ProfileFlowController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = tabBarController?.view.bounds ?? .zero
    }
}

// MARK: - protocol

extension ProfileFlowController: FlowController {

    func start() {
        let vc = Resources.ViewControllers.App.profile()
        vc.delegate = self

        tabBarItem.title = Resources.Strings.Profile.profile
        tabBarItem.image = Resources.Images.Tabs.profile

        navVC.viewControllers = [vc]
    }
}

// MARK: delegate

extension ProfileFlowController: ProfileViewControllerDelegate {

    func didLogoutButtonTapped() {
        delegate.didLogoutButtonTapped()
    }
}
