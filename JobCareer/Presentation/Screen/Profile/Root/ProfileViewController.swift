import UIKit

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

final class ProfileViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    weak var delegate: ProfileViewControllerDelegate!
}

// MARK: - override methods

extension ProfileViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
        ui.setupCollectionView(delegate: self)
        ui.injectDelegate(delegate: self)
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

    func didLogoutButtonTapped() {
        delegate.didLogoutButtonTapped()
    }
}
