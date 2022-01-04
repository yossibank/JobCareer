import UIKit

extension HomeUI {

    func createLayout() -> UICollectionViewLayout {

        let sectionProvider = { (sectionIndex: Int, _: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in

            guard
                let sectionKind = HomeSection.allCases.any(at: sectionIndex)
            else {
                return nil
            }

            let section: NSCollectionLayoutSection

            switch sectionKind {
                case .news:
                    let itemSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 12)

                    let groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalWidth(0.5)
                    )
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitems: [item]
                    )

                    section = NSCollectionLayoutSection(group: group)
                    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

                case .contents:
                    let leadingItemSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.6),
                        heightDimension: .fractionalHeight(1.0)
                    )
                    let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
                    leadingItem.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)

                    let trailingItemSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(0.3)
                    )
                    let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
                    trailingItem.contentInsets = .init(top: 8, leading: 12, bottom: 8, trailing: 8)

                    let trailingGroupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.4),
                        heightDimension: .fractionalHeight(1.0)
                    )
                    let trailingGroup = NSCollectionLayoutGroup.vertical(
                        layoutSize: trailingGroupSize,
                        subitem: trailingItem,
                        count: 2
                    )

                    let nestedGroupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(0.4)
                    )
                    let nestedGroup = NSCollectionLayoutGroup.horizontal(
                        layoutSize: nestedGroupSize,
                        subitems: [leadingItem, trailingGroup]
                    )

                    section = NSCollectionLayoutSection(group: nestedGroup)
                    section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 4)
            }

            if #available(iOS 14.0, *) {
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(44)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: HomeHeader.resourceName,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [header]
            }

            return section
        }

        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}
