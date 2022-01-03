import UIKit

extension HomeUI {

    func configureDataSource(
        collectionView: UICollectionView
    ) -> UICollectionViewDiffableDataSource<HomeSection, HomeItem> {
        .init(collectionView: collectionView) { collectionView, indexPath, item in
            guard
                let section = HomeSection.allCases.any(at: indexPath.section)
            else {
                return nil
            }

            switch (section, item) {
                case let (.news, .news(content)):
                    guard
                        let cell = collectionView.dequeueReusableCell(
                            withReuseIdentifier: NewsCell.resourceName,
                            for: indexPath
                        ) as? NewsCell
                    else {
                        return UICollectionViewCell()
                    }

                    cell.configure(
                        title: content.title,
                        description: content.description
                    )

                    return cell

                case (.contents, .contents):
                    let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: UICollectionViewCell.resourceName,
                        for: indexPath
                    )

                    cell.backgroundColor = .yellow

                    return cell

                default:
                    return nil
            }
        }
    }
}
