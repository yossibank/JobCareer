import UIKit

// MARK: - stored properties & init

final class HomeFlowController: UIViewController {

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

        tabBarItem.title = "HOME"
        tabBarItem.image = UIImage(systemName: "a.circle")

        navVC.viewControllers = [vc]
    }
}

// MARK: - delegate

extension HomeFlowController: HomeViewControllerDelegate {

    func didItemSelected() {
        print("TAP")
    }
}
