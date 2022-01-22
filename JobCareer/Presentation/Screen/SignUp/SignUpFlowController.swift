import UIKit

// MARK: - screen transition management

protocol SignUpFlowControllerDelegate: AnyObject {
    func didSignUpButtonTapped()
}

// MARK: - stored properties & init

final class SignUpFlowController: UIViewController {

    private let navVC = NavigationController()

    weak var delegate: SignUpFlowControllerDelegate?

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

extension SignUpFlowController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = view.bounds
    }
}

// MARK: - protocol

extension SignUpFlowController: FlowController {

    func start() {
        let vc = Resources.ViewControllers.App.signUp()
        vc.delegate = self

        navVC.viewControllers = [vc]
    }
}

// MARK: - delegate

extension SignUpFlowController: SignUpViewControllerDelegate {

    func didSignUpButtonTapped() {
        delegate?.didSignUpButtonTapped()
    }
}
