import UIKit

struct Main: Hashable {
    let name: String
    let icon: UIImage
}

// MARK: - stored properties & init

final class MainCell: UICollectionViewCell {
    private let nameLabel: UILabel = .init(
        styles: [.leftAlignment],
        fontType: .bold,
        fontSize: .h2
    )

    private let iconImageView: UIImageView = .init()

    private lazy var stackView: UIStackView = .init(
        subViews: [nameLabel, iconImageView],
        style: .vertical,
        distributon: .fillEqually,
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

extension MainCell {

    func configure(item: Main) {
        nameLabel.text = item.name
        iconImageView.image = item.icon
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
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        )
    }
}
