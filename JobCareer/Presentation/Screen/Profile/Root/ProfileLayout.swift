import UIKit

extension ProfileUI {

    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { [weak self] (sectionIndex: Int, _: NSCollectionLayoutEnvironment)
            -> NSCollectionLayoutSection? in

            guard
                let self = self,
                let sectionKind = ProfileSection.allCases.any(at: sectionIndex)
            else {
                return nil
            }

            let section: NSCollectionLayoutSection

            switch sectionKind {
                case .main:
                    let itemSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)

                    let groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(0.6)
                    )
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitem: item,
                        count: 1
                    )

                    section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = .init(top: 8, leading: 12, bottom: 8, trailing: 12)
                    self.createHeader(section: section)

                case .career:
                    let itemSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(44)
                    )
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)

                    let groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .estimated(44)
                    )
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitem: item,
                        count: 1
                    )

                    section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = .init(top: 8, leading: 12, bottom: 8, trailing: 12)
                    self.createHeader(section: section)

                case .logout:
                    let itemSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(56)
                    )
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)

                    let groupSize = NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(56)
                    )
                    let group = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitem: item,
                        count: 1
                    )

                    section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = .init(top: 32, leading: 96, bottom: 32, trailing: 96)
            }

            section.interGroupSpacing = 12
            return section
        }

        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }

    private func createHeader(section: NSCollectionLayoutSection) {
        if #available(iOS 14.0, *) {
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: CollectionViewHeader.resourceName,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        }
    }
}
