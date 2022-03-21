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

    private var dataSource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>!
}

// MARK: - internal methods

extension HomeUI {

    func setupCollectionView(delegate: UICollectionViewDelegate) {
        dataSource = configureDataSource(collectionView: collectionView)

        collectionView.register(
            CollectionViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CollectionViewHeader.resourceName
        )

        collectionView.register(
            NewsCell.self,
            forCellWithReuseIdentifier: NewsCell.resourceName
        )

        collectionView.register(
            ContentsCell.self,
            forCellWithReuseIdentifier: ContentsCell.resourceName
        )

        if #available(iOS 14.0, *) {
            let header = UICollectionView.SupplementaryRegistration<CollectionViewHeader>(
                elementKind: CollectionViewHeader.resourceName
            ) { view, _, indexPath in
                guard let section = HomeSection.allCases.any(at: indexPath.section) else {
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
    }

    func apply() {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
        dataSourceSnapshot.appendSections(HomeSection.allCases)

        dataSourceSnapshot.appendItems(
            [
                .contents(.init(image: Resources.Images.Test.testIcon, description: "content1")),
                .contents(.init(image: Resources.Images.Test.testIcon, description: "content2")),
                .contents(.init(image: Resources.Images.Test.testIcon, description: "content3")),
                .contents(.init(image: Resources.Images.Test.testIcon, description: "content4")),
                .contents(.init(image: Resources.Images.Test.testIcon, description: "content5")),
                .contents(.init(image: Resources.Images.Test.testIcon, description: "content6"))
            ],
            toSection: .contents
        )

        dataSourceSnapshot.appendItems(
            [
                .news(.init(title: "news1", description: "description1")),
                .news(.init(title: "news2", description: "description2")),
                .news(.init(title: "news3", description: "description3")),
                .news(.init(title: "news4", description: "description4")),
                .news(.init(title: "news5", description: "description5")),
                .news(.init(title: "news6", description: "description6"))
            ],
            toSection: .news
        )

        dataSource.apply(
            dataSourceSnapshot,
            animatingDifferences: false
        )
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
