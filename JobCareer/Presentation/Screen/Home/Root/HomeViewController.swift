import UIKit

extension HomeViewController: VCInjectable {
    typealias VM = NoViewModel
    typealias UI = HomeUI
}

// MARK: - stored properties

final class HomeViewController: UIViewController {
    var viewModel: VM!
    var ui: UI!
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
        _: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print(indexPath)
    }
}
