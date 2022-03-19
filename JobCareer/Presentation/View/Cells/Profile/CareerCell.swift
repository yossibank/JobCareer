import UIKit

// MARK: - stored properties & init

final class CareerCell: UICollectionViewCell {
    private let titleLabel: UILabel = .init(
        style: .careerTitle
    )

    private let descriptionLabel: UILabel = .init(
        style: .carrerDescription
    )

    private lazy var stackView: UIStackView = .init(
        subViews: [titleLabel, descriptionLabel],
        style: .vertical,
        distributon: .fillEqually,
        alignment: .leading,
        space: 10
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
