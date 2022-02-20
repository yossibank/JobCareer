#if DEBUG

import Combine
import UIKit

// MARK: - stored properties & init

final class ThemeCell: UITableViewCell {

    private enum ThemeType: String, CaseIterable {
        case system
        case light
        case dark
    }

    private lazy var stackView: UIStackView = .init(
        subViews: [titleLabel, themeSegment],
        style: .horizontal,
        distributon: .fillEqually,
        alignment: .fill
    )

    private let titleLabel: UILabel = .init(
        styles: [.leftAlignment],
        fontType: .italic,
        fontSize: .h2
    )

    private let themeSegment: UISegmentedControl = {
        let themeSegment = UISegmentedControl()
        ThemeType.allCases.enumerated().forEach { index, type in
            themeSegment.insertSegment(
                withTitle: type.rawValue,
                at: index,
                animated: false
            )
        }
        return themeSegment
    }()

    lazy var segmentPublisher: AnyPublisher<Int, Never> = {
        themeSegment.selectedIndexPublisher
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - internal methods

extension ThemeCell {

    func configure(title: String, value: Int?) {
        titleLabel.text = title.addSpaceAfterUppercase().uppercased()
        themeSegment.selectedSegmentIndex = value ?? 0
    }
}

// MARK: - private methods

private extension ThemeCell {

    func setupView() {
        contentView.addSubViews(
            stackView,

            constraints:
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        )
    }
}

#endif
