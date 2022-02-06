import Combine
import UIKit
import Utility

// MARK: - screen transition management

protocol SignUpViewControllerDelegate: AnyObject {
    func didRegisterAccount()
}

// MARK: - inject

extension SignUpViewController: VCInjectable {
    typealias VM = SignUpViewModel
    typealias UI = SignUpUI
}

// MARK: - stored properties

final class SignUpViewController: IndicatorViewController {
    var viewModel: VM!
    var ui: UI!

    weak var delegate: SignUpViewControllerDelegate!

    private var keyboardHandler: KeyboardHandler?
    private var cancellables: Set<AnyCancellable> = []
}

// MARK: - override methods

extension SignUpViewController {

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
}

// MARK: - private methods

private extension SignUpViewController {

    func setupKeyboard() {
        keyboardHandler = KeyboardHandler { [weak self] keyboard in
            guard let self = self else { return }

            let offsetY = self.ui.getSignUpButtonOffsetY(rootView: self.view)
            let space = 100.0
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
        ui.buttonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.signUp()
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

        ui.confirmPasswordTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.confirmPassword, on: viewModel)
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
                        self.showBottomSheet(
                            type: .signUp(
                                content: .init(
                                    handler: { [weak self] in
                                        self?.presentingViewController?.dismiss(animated: true)
                                        self?.delegate.didRegisterAccount()
                                    }
                                )
                            )
                        )
                        Logger.debug(message: "\(entity)")

                    case let .failed(error):
                        self.stopIndicator()
                        self.showBottomSheet(
                            type: .error(
                                content: .init(
                                    body: error.errorMessage?.contain(pattern: "already") ?? false
                                        ? Resources.Strings.Alert.duplicateEmailAddress
                                        : Resources.Strings.Alert.failedSignUpMessage,
                                    handler: { [weak self] in
                                        self?.dismiss(animated: true)
                                    }
                                )
                            )
                        )
                        Logger.debug(message: "\(error.localizedDescription)")
                }
            }
            .store(in: &cancellables)

        viewModel.emailValidated
            .dropFirst()
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] validation in
                guard let self = self else { return }

                switch validation {
                    case .none:
                        break

                    case .valid:
                        self.ui.setValidationText(
                            text: "OK ✅",
                            validColor: .green,
                            type: .email
                        )

                    case let .invalid(error):
                        self.ui.setValidationText(
                            text: error.localizedDescription,
                            validColor: .red,
                            type: .email
                        )
                }
            }
            .store(in: &cancellables)

        viewModel.passwordValidated
            .dropFirst()
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] validation in
                guard let self = self else { return }

                switch validation {
                    case .none:
                        break

                    case .valid:
                        self.ui.setValidationText(
                            text: "OK ✅",
                            validColor: .green,
                            type: .password
                        )

                    case let .invalid(error):
                        self.ui.setValidationText(
                            text: error.localizedDescription,
                            validColor: .red,
                            type: .password
                        )
                }
            }
            .store(in: &cancellables)

        viewModel.confirmPasswordValidated
            .dropFirst()
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] validation in
                guard let self = self else { return }

                switch validation {
                    case .none:
                        break

                    case .valid:
                        self.ui.setValidationText(
                            text: "OK ✅",
                            validColor: .green,
                            type: .confirmPassword
                        )

                    case let .invalid(error):
                        self.ui.setValidationText(
                            text: error.localizedDescription,
                            validColor: .red,
                            type: .confirmPassword
                        )
                }
            }
            .store(in: &cancellables)

        viewModel.isEnabled
            .debounce(for: 0.1, scheduler: DispatchQueue.main)
            .sink { [weak self] isEnabled in
                guard let self = self else { return }
                self.ui.isEnabled = isEnabled
            }
            .store(in: &cancellables)
    }
}

// MARK: - delegate
extension SignUpViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
