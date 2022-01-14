import Combine
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
                case let (.main, .main(item)):
                    guard
                        let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: MainCell.resourceName,
                            for: indexPath
                        ) as? MainCell
                    else {
                        return UICollectionViewCell()
                    }

                    cell.configure(item: item)

                    return cell

                case let (.career, .career(item)):
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

                case (.logout, .logout):
                    guard
                        let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: LogoutCell.resourceName,
                            for: indexPath
                        ) as? LogoutCell
                    else {
                        return UICollectionViewCell()
                    }

                    cell.buttonTapPublisher.sink { _ in
                        print("TAP!!!")
                    }
                    .store(in: &self.cancellables)

                    return cell

                default:
                    return nil
            }
        }
    }
}
