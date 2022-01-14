import UIKit

protocol MainFlowControllerDelegate: AnyObject {
    func showMainView()
    func didLogoutButtonTapped()
}

// MARK: - stored properties & init

final class MainFlowController: UIViewController {

    weak var delegate: MainFlowControllerDelegate!

    private let tabController = TabBarController()

    init() {
        super.init(nibName: nil, bundle: nil)
        add(tabController)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - override methods

extension MainFlowController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = view.bounds
    }
}

// MARK: - protocol

extension MainFlowController: FlowController {

    func start() {
        let flows: [FlowController]

        let homeFlowController = HomeFlowController()
        homeFlowController.delegate = self

        let profileFlowController = ProfileFlowController()
        profileFlowController.delegate = self

        let debugFlowController = DEBUG_FlowController()
        debugFlowController.delegate = self

        #if DEBUG
        flows = [homeFlowController, profileFlowController, debugFlowController]
        #else
        flows = [homeFlowController, profileFlowController]
        #endif

        tabController.setViewControllers(flows, animated: false)

        flows.forEach { $0.start() }
    }
}

extension MainFlowController: MainFlowControllerDelegate {

    func showMainView() {
        delegate.showMainView()
    }

    func didLogoutButtonTapped() {
        tabController.selectedIndex = TabBarType.home.rawValue
        delegate.didLogoutButtonTapped()
    }
}
