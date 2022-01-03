import UIKit

// MARK: - stored properties & init

final class NewsCell: UICollectionViewCell {

    private let titleLabel: UILabel = .init(
        styles: [.centerAlignment],
        fontType: .bold,
        fontSize: .h1
    )

    private let descriptionLabel: UILabel = .init(
        styles: [.leftAlignment],
        fontType: .system,
        fontSize: .h3
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

    func configure(title: String, description: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}

// MARK: - private methods

private extension NewsCell {

    func setupView() {
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.random.cgColor
        contentView.layer.cornerRadius = 8.0

        contentView.addSubViews(
            titleLabel,
            descriptionLabel,

            constraints:
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        )
    }
}
