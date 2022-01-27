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

final class SignUpViewController: UIViewController {
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
        setupKeyboard()
        setupEvent()
        bindToViewModel()
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
            let space = 64.0
            let resizeOffsetY = self.view.frame.height - offsetY - keyboard.height - space

            switch keyboard.state {
                case .willShow:
                    UIView.animate(withDuration: keyboard.animationDuration) {
                        self.view.frame.origin.y == 0 ? self.view.frame.origin.y += resizeOffsetY : ()
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

        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }

                switch state {
                    case .standby:
                        Logger.debug(message: "standby")

                    case .loading:
                        Logger.debug(message: "loading")

                    case let .done(entities):
                        AppDataHolder.isLogin = true
                        self.delegate.didRegisterAccount()
                        Logger.debug(message: "\(entities)")

                    case let .failed(error):
                        Logger.debug(message: "\(error.localizedDescription)")
                }
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
}
