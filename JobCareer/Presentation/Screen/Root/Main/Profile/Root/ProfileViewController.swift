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
        ui.apply(item: nil)
        viewModel.fetch()
        bindToView()
    }
}

// MARK: - private methods

private extension ProfileViewController {

    func bindToView() {
        viewModel.$authState
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
                        self.showBottomSheet(
                            type: .error(.init(body: Resources.Strings.Alert.failedErrorMessage) { [weak self] in
                                self?.dismiss(animated: true)
                            })
                        )
                        Logger.debug(message: "\(error.localizedDescription)")
                }
            }
            .store(in: &cancellables)

        viewModel.$firestoreState
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
                        self.stopIndicator()
                        self.ui.apply(
                            item: .init(
                                name: entity.name ?? .blank,
                                iconUrl: entity.iconUrl ?? .blank
                            )
                        )
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

    func didWithdrawalButtonTapped(_ publisher: UIControl.Publisher<AnimationButton>) {
        let bottomSheetContent = WithdrawalBottomSheetContent()

        bottomSheetContent.withdrawalButtonTapPublisher
            .sink { [weak self] _ in
                self?.dismiss(animated: true)
                self?.viewModel.withdrawal()
                bottomSheetContent.clearText()
            }
            .store(in: &cancellables)

        bottomSheetContent.passwordTextPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.passowrd, on: viewModel)
            .store(in: &cancellables)

        viewModel.isEnabled
            .receive(on: DispatchQueue.main)
            .sink { isEnabled in
                bottomSheetContent.isEnabled = isEnabled
            }
            .store(in: &cancellables)

        publisher.sink { [weak self] _ in
            self?.showBottomSheet(view: bottomSheetContent)
        }
        .store(in: &cancellables)
    }
}
