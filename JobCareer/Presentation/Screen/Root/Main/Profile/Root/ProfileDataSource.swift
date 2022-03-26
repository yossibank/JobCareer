import UIKit

extension ProfileUI {

    func configureDataSource(
        collectionView: UICollectionView
    ) -> UICollectionViewDiffableDataSource<ProfileSection, ProfileItem> {
        .init(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            switch item {
                case let .main(item):
                    guard
                        let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: MainCell.resourceName,
                            for: indexPath
                        ) as? MainCell
                    else {
                        return UICollectionViewCell()
                    }

                    if let item = item {
                        cell.configure(item: item)
                    }

                    self?.delegate.didLogoutButtonTapped(cell.buttonTapPublisher)

                    return cell

                case let .career(item):
                    guard
                        let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: CareerCell.resourceName,
                            for: indexPath
                        ) as? CareerCell
                    else {
                        return UICollectionViewCell()
                    }

                    cell.configure(item: item)

                    return cell

                case .logout:
                    guard
                        let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: WithdrawalCell.resourceName,
                            for: indexPath
                        ) as? WithdrawalCell
                    else {
                        return UICollectionViewCell()
                    }

                    self?.delegate.didWithdrawalButtonTapped(cell.buttonTapPublisher)

                    return cell
            }
        }
    }
}
