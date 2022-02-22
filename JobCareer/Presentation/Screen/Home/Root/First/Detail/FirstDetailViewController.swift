import Combine
import UIKit

// MARK: - inject

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
        ui.homeButtonTapPublisher.sink { [weak self] _ in
            self?.delegate.didHomeButtonTapped()
        }
        .store(in: &cancellables)
    }
}
