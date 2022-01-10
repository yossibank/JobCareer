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
            CollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionViewHeader.resourceName
        )

        collectionView.register(
            MainCell.self,
            forCellWithReuseIdentifier: MainCell.resourceName
        )

        collectionView.register(
            CareerCell.self,
            forCellWithReuseIdentifier: CareerCell.resourceName
        )

        if #available(iOS 14.0, *) {
            let header = UICollectionView.SupplementaryRegistration<CollectionViewHeader>(
                elementKind: CollectionViewHeader.resourceName
            ) { view, _, indexPath in
                guard
                    let section = ProfileSection.allCases.any(at: indexPath.section)
                else {
                    return
                }

                view.configure(title: section.description)
            }

            dataSource.supplementaryViewProvider = { collectionView, _, indexPath in
                collectionView.dequeueConfiguredReusableSupplementary(
                    using: header,
                    for: indexPath
                )
            }
        }

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
