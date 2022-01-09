import UIKit

struct Career: Hashable {
    let title: String
    let description: String
}

// MARK: - stored properties & init

final class CareerCell: UICollectionViewCell {

    private lazy var stackView: UIStackView = .init(
        subViews: [titleLabel, descriptionLabel],
        style: .vertical,
        distributon: .fillEqually,
        alignment: .leading,
        space: 10
    )

    private let titleLabel: UILabel = .init(
        styles: [.leftAlignment],
        fontType: .bold,
        fontSize: .h1
    )

    private let descriptionLabel: UILabel = .init(
        styles: [.leftAlignment, .numberOfLinesZero],
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

extension CareerCell {

    func configure(item: Career) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
    }
}

// MARK: - private methods

private extension CareerCell {

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
