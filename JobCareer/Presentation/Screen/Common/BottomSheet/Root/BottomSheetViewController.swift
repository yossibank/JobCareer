import UIKit

// MARK: - inject

extension BottomSheetViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = BottomSheetUI
}

// MARK: - stored properties & init

final class BottomSheetViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    private var contentView: UIView?
    private var dismissCallback: VoidBlock?
    private var keyboardHandler: KeyboardHandler?

    init(dismissCallBack: VoidBlock? = nil) {
        self.dismissCallback = dismissCallBack
        super.init(nibName: nil, bundle: nil)
        setupKeyboard()
    }

    required init?(coder: NSCoder) {
        self.dismissCallback = nil
        super.init(coder: coder)
        setupKeyboard()
    }
}

// MARK: - override methods

extension BottomSheetViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        modalTransitionStyle = .coverVertical
        modalPresentationStyle = .formSheet

        ui.setupView(rootView: view)

        if let view = contentView {
            ui.set(view: view)
        }

        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(viewTapped)
        )

        view.addGestureRecognizer(gestureRecognizer)

        presentationController?.delegate = self
    }
}

// MARK: - internal methods

extension BottomSheetViewController {

    func set(view: UIView) {
        contentView = view
    }
}

// MARK: - private methods

private extension BottomSheetViewController {

    func setupKeyboard() {
        keyboardHandler = KeyboardHandler { [weak self] keyboard in
            guard let self = self else { return }

            switch keyboard.state {
                case .willShow:
                    UIView.animate(withDuration: keyboard.animationDuration) {
                        self.view.frame.origin.y == 0 ? self.view.frame.origin.y -= (keyboard.height - 16) : ()
                    }

                case .willHide, .unset:
                    self.view.frame.origin.y = 0
            }
        }
    }

    @objc func viewTapped() {
        dismiss(animated: true) { [weak self] in
            self?.dismissCallback?()
        }
    }
}

// MARK: - delegate

extension BottomSheetViewController: UIAdaptivePresentationControllerDelegate {

    func presentationControllerDidDismiss(_: UIPresentationController) {
        dismiss(animated: true) { [weak self] in
            self?.dismissCallback?()
        }
    }
}
