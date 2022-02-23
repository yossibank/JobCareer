import UIKit

// MARK: - stored properties & init

final class NewsCell: UICollectionViewCell {
    private let titleLabel: UILabel = .init(
        styles: [.centerAlignment],
        fontType: .bold,
        fontSize: .h1
    )

    private let descriptionLabel: UILabel = .init(
        styles: [.leftAlignment, .numberOfLinesZero],
        fontType: .system,
        fontSize: .h3
    )

    private lazy var stackView: UIStackView = .init(
        subViews: [titleLabel, descriptionLabel],
        style: .vertical,
        distributon: .fill,
        alignment: .fill,
        space: 12
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - internal methods

extension NewsCell {

    func configure(item: News) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}

// MARK: - private methods

private extension NewsCell {

    func setupView() {
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.random.cgColor
        contentView.layer.cornerRadius = 8.0

        contentView.addSubViews(
            stackView,

            constraints:
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        )
    }
}
