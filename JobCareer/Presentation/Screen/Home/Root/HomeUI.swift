import UIKit

// MARK: - stored properties

final class HomeUI {

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )

        return collectionView
    }()

    private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
    private var dataSource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>!
}

// MARK: - internal methods

extension HomeUI {

    func setupCollectionView(delegate: UICollectionViewDelegate) {
        dataSource = configureDataSource()

        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: UICollectionViewCell.resourceName
        )
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate

        dataSourceSnapshot.appendSections(HomeSection.allCases)

        HomeSection.allCases.forEach {
            dataSourceSnapshot.appendItems($0.initialItems, toSection: $0)
        }

        dataSource.apply(
            dataSourceSnapshot,
            animatingDifferences: false
        )
    }
}

// MARK: - private methods

private extension HomeUI {

    func configureDataSource() -> UICollectionViewDiffableDataSource<HomeSection, HomeItem> {
        .init(collectionView: collectionView) { collectionView, indexPath, _ in
            guard
                let section = HomeSection.allCases.any(at: indexPath.section)
            else {
                return nil
            }

            switch section {
                case .news:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: UICollectionViewCell.resourceName,
                        for: indexPath
                    )

                    cell.backgroundColor = .red

                    return cell

                case .contents:
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: UICollectionViewCell.resourceName,
                        for: indexPath
                    )

                    cell.backgroundColor = .yellow

                    return cell
            }
        }
    }
}

// MARK: - protocol

extension HomeUI: UserInterface {

    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            collectionView,

            constraints:
            collectionView.topAnchor.constraint(equalTo: rootView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor)
        )
    }
}
