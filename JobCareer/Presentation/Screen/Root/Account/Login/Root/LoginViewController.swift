import Combine
import UIKit
import Utility

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

final class LoginViewController: IndicatorViewController {
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
        ui.setupTextField(delegate: self)
        setupKeyboard()
        setupEvent()
        bindToViewModel()
        bindToView()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        ui.setThemeColor()
    }
}

// MARK: - private methods

private extension LoginViewController {

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

    func setupEvent() {
        ui.loginButtonTapPublisher.sink { [weak self] _ in
            self?.viewModel.login()
        }
        .store(in: &cancellables)

        ui.testLoginButtonTapPublisher.sink { [weak self] _ in
            self?.viewModel.testLogin()
        }
        .store(in: &cancellables)

        ui.signUpButtonTapPublisher.sink { [weak self] _ in
            self?.delegate.didSignUpButtonTapped()
        }
        .store(in: &cancellables)
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

    func bindToView() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }

                switch state {
                    case .standby:
                        Logger.debug(message: "standby")

                    case .loading:
                        self.startIndicator()
                        Logger.debug(message: "loading")

                    case let .done(entity):
                        AppDataHolder.isLogin = true
                        self.stopIndicator()
                        self.delegate.didLoginButtonTapped()
                        Logger.debug(message: "\(entity)")

                    case let .failed(error):
                        self.stopIndicator()
                        self.showBottomSheet(
                            type: .error(.init(body: Resources.Strings.Alert.failedLoginMessage) { [weak self] in
                                self?.dismiss(animated: true)
                            })
                        )
                        Logger.debug(message: "\(error.localizedDescription)")
                }
            }
            .store(in: &cancellables)

        viewModel.emailValidated
            .dropFirst()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] validation in
                self?.ui.emailValidation = validation
            }
            .store(in: &cancellables)

        viewModel.passwordValidated
            .dropFirst()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { [weak self] validation in
                self?.ui.passwordValidation = validation
            }
            .store(in: &cancellables)

        viewModel.isEnabled
            .debounce(for: 0.1, scheduler: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                self?.ui.isEnabled = isEnabled
            }
            .store(in: &cancellables)
    }
}

// MARK: - delegate

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
