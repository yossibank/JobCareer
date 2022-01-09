import UIKit

extension ProfileUI {

    func configureDataSource(
        collectionView: UICollectionView
    ) -> UICollectionViewDiffableDataSource<ProfileSection, ProfileItem> {
        .init(collectionView: collectionView) { collectionView, indexPath, item in
            guard
                let section = ProfileSection.allCases.any(at: indexPath.section)
            else {
                return nil
            }

            switch (section, item) {
                case let (.main, .main(text)):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: UICollectionViewCell.resourceName,
                        for: indexPath
                    )

                    cell.backgroundColor = .red

                    return cell

                case let (.career, .career(text)):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: UICollectionViewCell.resourceName,
                        for: indexPath
                    )

                    cell.backgroundColor = .blue

                    return cell

                default:
                    return nil
            }
        }
    }
}
