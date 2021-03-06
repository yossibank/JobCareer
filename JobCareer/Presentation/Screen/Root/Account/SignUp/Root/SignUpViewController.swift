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

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        ui.setThemeColor()
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
            self?.viewModel.signUp()
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
                            type: .signUp(.init { [weak self] in
                                self?.presentingViewController?.dismiss(animated: true)
                                self?.delegate.didRegisterAccount()
                            })
                        )
                        Logger.debug(message: "\(entity)")

                    case let .failed(error):
                        self.stopIndicator()

                        let bodyMessage = error.errorMessage?.contain(pattern: "already") ?? false
                            ? Resources.Strings.Alert.duplicateEmailAddress
                            : Resources.Strings.Alert.failedSignUpMessage

                        self.showBottomSheet(
                            type: .error(.init(body: bodyMessage) { [weak self] in
                                self?.dismiss(animated: true)
                            })
                        )
                        Logger.debug(message: "\(error.localizedDescription)")
                }
            }
            .store(in: &cancellables)

        viewModel.emailValidated
            .dropFirst()
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] validation in
                self?.ui.emailValidation = validation
            }
            .store(in: &cancellables)

        viewModel.passwordValidated
            .dropFirst()
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] validation in
                self?.ui.passwordValidation = validation
            }
            .store(in: &cancellables)

        viewModel.confirmPasswordValidated
            .dropFirst()
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .sink { [weak self] validation in
                self?.ui.confirmPasswordValidation = validation
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
extension SignUpViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
