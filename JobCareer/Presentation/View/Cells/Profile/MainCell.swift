import UIKit

// MARK: - stored properties & init

final class MainCell: UICollectionViewCell {
    private lazy var stackView: UIStackView = .init(
        subViews: [accountStackView, specStackView],
        style: .vertical,
        distributon: .fill,
        alignment: .fill,
        space: 8
    )

    private lazy var accountStackView: UIStackView = .init(
        subViews: [iconImageView, nameLabel],
        style: .horizontal,
        distributon: .fill,
        alignment: .fill,
        space: 16
    )

    private let nameLabel: UILabel = .init(
        style: .profileName
    )

    private let iconImageView: UIImageView = .init()

    private lazy var specStackView: UIStackView = .init(
        subViews: [ageLabel, specLabel],
        style: .vertical,
        distributon: .fill,
        alignment: .fill,
        space: 8
    )

    private let ageLabel: UILabel = .init(
        style: .age
    )

    private let specLabel: UILabel = .init(
        style: .spec
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

extension MainCell {

    func configure(item: Main) {
        nameLabel.text = item.name
        iconImageView.image = item.icon

        if ageLabel.text == nil && specLabel.text == nil {
            specStackView.isHidden = true
        }

//        ageLabel.text = "25歳"
//        specLabel.text = "SPEC情報"
    }
}

// MARK: - private methods

private extension MainCell {

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
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            iconImageView.widthAnchor.constraint(equalToConstant: 56),
            iconImageView.heightAnchor.constraint(equalToConstant: 56)
        )
    }
}
