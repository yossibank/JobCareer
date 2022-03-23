import Combine
import UIKit

// MARK: - screen transition management

protocol ProfileViewDelegate: AnyObject {
    func didLogoutButtonTapped(_ publisher: UIControl.Publisher<AnimationButton>)
}

// MARK: - stored properties

final class ProfileUI {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        return collectionView
    }()

    weak var delegate: ProfileViewDelegate!

    private var dataSource: UICollectionViewDiffableDataSource<ProfileSection, ProfileItem>!
}

// MARK: - internal methods

extension ProfileUI {

    func injectDelegate(delegate: ProfileViewDelegate) {
        self.delegate = delegate
    }

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

        collectionView.register(
            LogoutCell.self,
            forCellWithReuseIdentifier: LogoutCell.resourceName
        )

        if #available(iOS 14.0, *) {
            let header = UICollectionView.SupplementaryRegistration<CollectionViewHeader>(
                elementKind: CollectionViewHeader.resourceName
            ) { view, _, indexPath in
                guard let section = ProfileSection.allCases.any(at: indexPath.section) else {
                    return
                }

                switch section {
                    case .main, .career:
                        view.configure(title: section.description)

                    default:
                        break
                }
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

    func apply(item: Main?) {
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<ProfileSection, ProfileItem>()
        dataSourceSnapshot.appendSections(ProfileSection.allCases)

        dataSourceSnapshot.appendItems([.main(item)], toSection: .main)
        dataSourceSnapshot.appendItems(
            [
                .career(.init(title: "CAREER1", description: "career description")),
                .career(.init(title: "CAREER2", description: "career description2"))
            ],
            toSection: .career
        )
        dataSourceSnapshot.appendItems([.logout], toSection: .logout)

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
