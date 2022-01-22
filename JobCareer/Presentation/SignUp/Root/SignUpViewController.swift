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

    private var cancellables: Set<AnyCancellable> = []
}

// MARK: - override methods

extension SignUpViewController {

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

private extension SignUpViewController {

    func setupEvent() {
        ui.buttonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            AppDataHolder.isLogin = true
            self.delegate.didRegisterAccount()
        }
        .store(in: &cancellables)
    }
}
