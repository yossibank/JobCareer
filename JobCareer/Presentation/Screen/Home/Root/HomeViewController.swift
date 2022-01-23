import UIKit

// MARK: - screen transition management

protocol HomeViewControllerDelegate: AnyObject {
    func didFirstButtonTapped()
    func didFirstDetailButtonTapped()
    func didHomeButtonTapped()
}

// MARK: - inject

extension HomeViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = HomeUI
}

// MARK: - stored properties

final class HomeViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!

    weak var delegate: HomeViewControllerDelegate!
}

// MARK: - override methods

extension HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ui.setupView(rootView: view)
        ui.setupCollectionView(delegate: self)
    }
}

// MARK: - delegate

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(
            at: indexPath,
            animated: true
        )

        delegate.didFirstButtonTapped()
    }
}
