import UIKit

extension ProfileUI {

    func configureDataSource(
        collectionView: UICollectionView
    ) -> UICollectionViewDiffableDataSource<ProfileSection, ProfileItem> {
        .init(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard
                let self = self,
                let section = ProfileSection.allCases.any(at: indexPath.section)
            else {
                return nil
            }

            switch section {
                case .main:
                    guard
                        let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: MainCell.resourceName,
                            for: indexPath
                        ) as? MainCell
                    else {
                        return UICollectionViewCell()
                    }

                    if case let .main(item) = item {
                        cell.configure(item: item)
                    }

                    return cell

                case .career:
                    guard
                        let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: CareerCell.resourceName,
                            for: indexPath
                        ) as? CareerCell
                    else {
                        return UICollectionViewCell()
                    }

                    if case let .career(item) = item {
                        cell.configure(item: item)
                    }

                    return cell

                case .logout:
                    guard
                        let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: LogoutCell.resourceName,
                            for: indexPath
                        ) as? LogoutCell
                    else {
                        return UICollectionViewCell()
                    }

                    self.delegate.didLogoutButtonTapped(cell.buttonTapPublisher)
                    return cell
            }
        }
    }
}
