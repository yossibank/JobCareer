import Combine
import UIKit
import Utility

// MARK: - screen transition management

protocol ProfileViewControllerDelegate: AnyObject {
    func didLogoutButtonTapped()
}

// MARK: - inject

extension ProfileViewController: VCInjectable {
    typealias VM = ProfileViewModel
    typealias UI = ProfileUI
}

// MARK: - stored properties

final class ProfileViewController: IndicatorViewController {
    var viewModel: VM!
    var ui: UI!

    weak var delegate: ProfileViewControllerDelegate!

    private var cancellables: Set<AnyCancellable> = []
}

// MARK: - override methods

extension ProfileViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.injectDelegate(delegate: self)
        ui.setupView(rootView: view)
        ui.setupCollectionView(delegate: self)
        bindToView()
    }
}

// MARK: - private methods

private extension ProfileViewController {

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
                        AppDataHolder.isLogin = false
                        self.stopIndicator()
                        self.delegate.didLogoutButtonTapped()
                        Logger.debug(message: "\(entity)")

                    case let .failed(error):
                        self.stopIndicator()
                        Logger.debug(message: "\(error.localizedDescription)")
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - delegate

extension ProfileViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(
            at: indexPath,
            animated: true
        )

        print(indexPath)
    }
}

extension ProfileViewController: ProfileViewDelegate {

    func didLogoutButtonTapped(_ publisher: UIControl.Publisher<AnimationButton>) {
        publisher.sink { [weak self] _ in
            self?.showBottomSheet(
                type: .logout(.init { [weak self] in
                    self?.dismiss(animated: true)
                    self?.viewModel.logout()
                })
            )
        }
        .store(in: &cancellables)
    }
}
