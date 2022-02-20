import UIKit

struct Contents: Hashable {
    let image: UIImage?
    let description: String
}

// MARK: - stored properties & init

final class ContentsCell: UICollectionViewCell {

    private lazy var stackView: UIStackView = .init(
        subViews: [labelView, contentImageView],
        style: .vertical,
        distributon: .fillEqually,
        alignment: .fill,
        space: 10
    )

    private let contentImageView: UIView = .init()

    private let imageView: UIImageView = .init(
        style: .contentImage
    )

    private let labelView: UIView = .init()

    private let descriptionLabel: UILabel = .init(
        styles: [.leftAlignment, .contentLines],
        fontType: .italic,
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

extension ContentsCell {

    func configure(item: Contents, index: Int) {
        contentImageView.isHidden = item.image == nil || index % 3 != 0
        imageView.image = item.image
        descriptionLabel.text = item.description
    }
}

// MARK: - private methods

private extension ContentsCell {

    func setupView() {
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.random.cgColor
        contentView.layer.cornerRadius = 8.0

        contentImageView.addSubViews(
            imageView,

            constraints:
            imageView.centerXAnchor.constraint(equalTo: contentImageView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentImageView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        )

        labelView.addSubViews(
            descriptionLabel,

            constraints:
            descriptionLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor)
        )

        contentView.addSubViews(
            stackView,

            constraints:
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        )
    }
}
