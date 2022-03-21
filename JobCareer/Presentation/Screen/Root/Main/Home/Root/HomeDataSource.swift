import UIKit

extension HomeUI {

    func configureDataSource(
        collectionView: UICollectionView
    ) -> UICollectionViewDiffableDataSource<HomeSection, HomeItem> {
        .init(collectionView: collectionView) { collectionView, indexPath, item in
            guard let section = HomeSection.allCases.any(at: indexPath.section) else {
                return nil
            }

            switch section {
                case .news:
                    guard
                        let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: NewsCell.resourceName,
                            for: indexPath
                        ) as? NewsCell
                    else {
                        return UICollectionViewCell()
                    }

                    if case let .news(item) = item {
                        cell.configure(item: item)
                    }

                    return cell

                case .contents:
                    guard
                        let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: ContentsCell.resourceName,
                            for: indexPath
                        ) as? ContentsCell
                    else {
                        return UICollectionViewCell()
                    }

                    if case let .contents(item) = item {
                        cell.configure(item: item, index: indexPath.row)
                    }

                    return cell
            }
        }
    }
}
