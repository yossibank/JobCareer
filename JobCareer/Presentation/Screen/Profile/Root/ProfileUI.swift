import UIKit

// MARK: - stored properties

final class ProfileUI {

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )

        return collectionView
    }()

    private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<ProfileSection, ProfileItem>()
    private var dataSource: UICollectionViewDiffableDataSource<ProfileSection, ProfileItem>!
}

// MARK: - internal methods

extension ProfileUI {

    func setupCollectionView(delegate: UICollectionViewDelegate) {
        dataSource = configureDataSource(collectionView: collectionView)

        collectionView.register(
            MainCell.self,
            forCellWithReuseIdentifier: MainCell.resourceName
        )

        collectionView.register(
            CareerCell.self,
            forCellWithReuseIdentifier: CareerCell.resourceName
        )

        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate

        dataSourceSnapshot.appendSections(ProfileSection.allCases)

        ProfileSection.allCases.forEach {
            dataSourceSnapshot.appendItems($0.initialItems, toSection: $0)
        }

        dataSource.apply(
            dataSourceSnapshot,
            animatingDifferences: false
        )
    }
}

// MARK: - protocol

extension ProfileUI: UserInterface {

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
