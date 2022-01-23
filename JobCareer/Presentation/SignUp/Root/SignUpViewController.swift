import Combine
import UIKit

// MARK: - screen transition management

protocol SignUpViewControllerDelegate: AnyObject {
    func didRegisterAccount()
}

// MARK: - inject

extension SignUpViewController: VCInjectable {
    typealias VM = NoViewModel
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
        setupEvent()
        setupKeyboard()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

// MARK: - private methods

private extension SignUpViewController {

    func setupEvent() {
        ui.buttonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            AppDataHolder.isLogin = true
            self.delegate.didRegisterAccount()
        }
        .store(in: &cancellables)
    }

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
}
