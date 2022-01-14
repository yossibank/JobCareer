import UIKit

// MARK: - stored properties & init

final class HomeFlowController: UIViewController {

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

extension HomeFlowController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = tabBarController?.view.bounds ?? .zero
    }
}

// MARK: - protocol

extension HomeFlowController: FlowController {

    func start() {
        let vc = Resources.ViewControllers.App.home()
        vc.delegate = self

        tabBarItem.title = Resources.Strings.Home.home
        tabBarItem.image = Resources.Images.Tabs.home

        navVC.viewControllers = [vc]
    }
}

// MARK: - delegate

extension HomeFlowController: HomeViewControllerDelegate {

    func showFirstView() {
        let vc = Resources.ViewControllers.App.first()
        vc.delegate = self
        navVC.pushViewController(vc, animated: true)
    }

    func showFirstDetailView() {
        let vc = Resources.ViewControllers.App.firstDetail()
        vc.delegate = self
        navVC.pushViewController(vc, animated: true)
    }

    func showMainView() {
        delegate.showMainView(type: .home)
    }
}
