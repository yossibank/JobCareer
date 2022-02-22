import UIKit

// MARK: - screen transition management

protocol LoginFlowControllerDelegate: AnyObject {
    func didLoginButtonTapped()
    func didRegisterAccount()
}

// MARK: - stored properties & init

final class LoginFlowController: UIViewController {
    weak var delegate: LoginFlowControllerDelegate?

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

extension LoginFlowController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        children.first?.view.frame = view.bounds
    }
}

// MARK: - protocol

extension LoginFlowController: FlowController {

    func start() {
        let vc = Resources.ViewControllers.App.login()
        vc.delegate = self

        navVC.viewControllers = [vc]
    }
}

// MARK: - delegate

extension LoginFlowController: LoginViewControllerDelegate {

    func didLoginButtonTapped() {
        delegate?.didLoginButtonTapped()
    }

    func didSignUpButtonTapped() {
        let vc = Resources.ViewControllers.App.signUp()
        vc.delegate = self

        let navVC = NavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
}

extension LoginFlowController: SignUpViewControllerDelegate {

    func didRegisterAccount() {
        delegate?.didRegisterAccount()
    }
}
