#if DEBUG

import UIKit

// MARK: - stored properties & init

final class DEBUG_FlowController: UIViewController {
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

extension DEBUG_FlowController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = tabBarController?.view.bounds ?? .zero
    }
}

// MARK: - protocol

extension DEBUG_FlowController: FlowController {

    func start() {
        let vc = Resources.ViewControllers.App.debug()
        vc.delegate = self

        tabBarItem.title = Resources.Strings.Navigation.Title.debug
        tabBarItem.image = Resources.Images.Tabs.debug

        navVC.viewControllers = [vc]
    }
}

// MARK: - delegate

extension DEBUG_FlowController: DEBUG_ViewControllerDelegate {

    func didDevelopmentSelected(item: DEBUG_Development) {
        switch item {
            case .theme:
                print("theme")

            case .profile:
                print("save profile")
        }
    }

    func didComponentSelected(item: DEBUG_Component) {
        switch item {
            case .bottomSheetContent:
                let vc = Resources.ViewControllers.App.debugBottomSheetList()
                navVC.present(vc, animated: true)
        }
    }

    func didControllerSelected(item: DEBUG_Controller) {
        switch item {
            case .home:
                let vc = Resources.ViewControllers.App.home()
                vc.delegate = self
                navVC.pushViewController(vc, animated: true)

            case .profile:
                let vc = Resources.ViewControllers.App.profile()
                vc.delegate = self
                navVC.pushViewController(vc, animated: true)

            case .first:
                let vc = Resources.ViewControllers.App.first()
                vc.delegate = self
                navVC.pushViewController(vc, animated: true)

            case .firstDetail:
                let vc = Resources.ViewControllers.App.firstDetail()
                vc.delegate = self
                navVC.pushViewController(vc, animated: true)

            case .second:
                let vc = Resources.ViewControllers.App.second()
                navVC.pushViewController(vc, animated: true)
        }
    }

    func didChangeThemeSelected(value: Int) {
        delegate.didChangeThemeSelected(value: value)
    }
}

extension DEBUG_FlowController: HomeViewControllerDelegate {

    func didFirstButtonTapped() {
        let vc = Resources.ViewControllers.App.first()
        vc.delegate = self
        navVC.pushViewController(vc, animated: true)
    }

    func didFirstDetailButtonTapped() {
        let vc = Resources.ViewControllers.App.firstDetail()
        vc.delegate = self
        navVC.pushViewController(vc, animated: true)
    }

    func didHomeButtonTapped() {
        delegate.didHomeButtonTapped()
    }
}

extension DEBUG_FlowController: ProfileViewControllerDelegate {

    func didLogoutButtonTapped() {
        delegate.didLogoutButtonTapped()
    }
}

#endif
