import Combine
import UIKit

// MARK: - screen transition management

protocol LoginViewControllerDelegate: AnyObject {
    func didLoginButtonTapped()
    func didSignUpButtonTapped()
}

// MARK: - inject

extension LoginViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = LoginUI
}

// MARK: - stored properties

final class LoginViewController: UIViewController {

    var viewModel: VM!
    var ui: UI!

    weak var delegate: LoginViewControllerDelegate!

    private var cancellables: Set<AnyCancellable> = []
}

// MARK: - override methods

extension LoginViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ui.setupView(rootView: view)

        setupEvent()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - private methods

private extension LoginViewController {

    func setupEvent() {
        ui.loginButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            AppDataHolder.isLogin = true
            self.delegate.didLoginButtonTapped()
        }
        .store(in: &cancellables)

        ui.signUpButtonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.delegate.didSignUpButtonTapped()
        }
        .store(in: &cancellables)
    }
}
