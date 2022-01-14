import Combine
import UIKit

extension FirstDetailViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = FirstDetailUI
}

// MARK: - stored properties

final class FirstDetailViewController: UIViewController {

    var viewModel: VM!
    var ui: UI!

    weak var delegate: HomeViewControllerDelegate!

    private var cancellables: Set<AnyCancellable> = []
}

// MARK: - override methods

extension FirstDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ui.setupView(rootView: view)

        setupEvent()
    }
}

// MARK: - private methods

private extension FirstDetailViewController {

    func setupEvent() {
        ui.buttonTapPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.delegate.showMainView()
        }
        .store(in: &cancellables)
    }
}
