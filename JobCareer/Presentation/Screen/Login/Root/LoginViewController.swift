import Combine
import UIKit

// MARK: - screen transition management

protocol LoginViewControllerDelegate: AnyObject {
    func didLoginButtonTapped()
    func didSignUpButtonTapped()
}

// MARK: - inject

extension LoginViewController: VCInjectable {
    typealias VM = LoginViewModel
    typealias UI = LoginUI
}

// MARK: - stored properties

final class LoginViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    weak var delegate: LoginViewControllerDelegate!

    private var keyboardHandler: KeyboardHandler?
    private var cancellables: Set<AnyCancellable> = []
}

// MARK: - override methods

extension LoginViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
        setupEvent()
        setupKeyboard()
        bindToViewModel()
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
            self.viewModel.login()
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

    func setupKeyboard() {
        keyboardHandler = KeyboardHandler { [weak self] keyboard in
            guard let self = self else { return }

            let offsetY = self.ui.getLoginButtonOffsetY(rootView: self.view)
            let space = 64.0
            let resizeOffsetY = keyboard.height - (self.view.frame.height - offsetY) + space

            switch keyboard.state {
                case .willShow:
                    UIView.animate(withDuration: keyboard.animationDuration) {
                        self.view.frame.origin.y == 0 ? self.view.frame.origin.y -= resizeOffsetY : ()
                    }

                case .willHide, .unset:
                    self.view.frame.origin.y = 0
            }
        }
    }

    func bindToViewModel() {
        ui.emailTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellables)

        ui.passwordTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)
    }
}
