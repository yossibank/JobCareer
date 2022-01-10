import UIKit

extension ProfileViewController: VCInjectable {
    typealias VM = ProfileViewModel
    typealias UI = ProfileUI
}

// MARK: - stored properties

final class ProfileViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
}

// MARK: - override methods

extension ProfileViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
        ui.setupCollectionView(delegate: self)
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
