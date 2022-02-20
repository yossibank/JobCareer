#if DEBUG

import UIKit

// MARK: - stored properties

final class DEBUG_UI {
    private let tableView = UITableView()
    private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<DEBUG_Section, DEBUG_Item>()
    private var dataSource: UITableViewDiffableDataSource<DEBUG_Section, DEBUG_Item>!
}

// MARK: - internal methods

extension DEBUG_UI {

    func setupTableView(delegate: UITableViewDelegate) {
        dataSource = configureDataSource()

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: UITableViewCell.resourceName
        )
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }

        dataSourceSnapshot.appendSections(DEBUG_Section.allCases)

        dataSourceSnapshot.appendItems(
            DEBUG_Component.allCases.map { $0.component },
            toSection: .component
        )

        dataSourceSnapshot.appendItems(
            DEBUG_Controller.allCases.map { $0.component },
            toSection: .viewController
        )

        dataSource.apply(
            dataSourceSnapshot,
            animatingDifferences: false
        )
    }
}

// MARK: - private methods

private extension DEBUG_UI {

    func configureDataSource() -> UITableViewDiffableDataSource<DEBUG_Section, DEBUG_Item> {
        .init(tableView: tableView) { [weak self] tableView, indexPath, item in
            guard
                let self = self
            else {
                return UITableViewCell()
            }

            return self.makeCell(
                tableView: tableView,
                indexPath: indexPath,
                item: item
            )
        }
    }

    func makeCell(
        tableView: UITableView,
        indexPath : IndexPath,
        item: DEBUG_Item
    ) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: UITableViewCell.resourceName,
            for: indexPath
        )

        switch item {
            case let .component(content):
                cell.textLabel?.text = content.rawValue.addSpaceAfterUppercase().uppercased()

            case let .controller(content):
                cell.textLabel?.text = content.rawValue.addSpaceAfterUppercase().uppercased()
        }

        cell.textLabel?.font = .italicSystemFont(ofSize: 18)

        return cell
    }
}

// MARK: - protocol

extension DEBUG_UI: UserInterface {

    func setupView(rootView: UIView) {
        rootView.backgroundColor = .systemBackground

        rootView.addSubViews(
            tableView,

            constraints:
            tableView.topAnchor.constraint(equalTo: rootView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor)
        )
    }
}

#endif
