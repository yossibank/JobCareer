import UIKit

// MARK: - stored properties & init

final class MainCell: UICollectionViewCell {
    private lazy var stackView: UIStackView = .init(
        subViews: [accountStackView, specStackView, logoutStackView],
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

    private let iconImageView: UIImageView = .init(
        style: .profileIcon
    )

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

    private lazy var logoutStackView: UIStackView = .init(
        subViews: [UIView(), logoutButton],
        style: .horizontal,
        distributon: .fill,
        alignment: .trailing
    )

    private let logoutButton: AnimationButton = .init(
        style: .logout
    )

    lazy var buttonTapPublisher: UIControl.Publisher<AnimationButton> = {
        logoutButton.publisher(for: .touchUpInside)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        logoutButton.layer.borderColor = Resources.Colors.borderColor.cgColor
    }
}

// MARK: - internal methods

extension MainCell {

    func configure(item: Main) {
        nameLabel.text = item.name
        iconImageView.loadImage(with: item.iconUrl)

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
            iconImageView.heightAnchor.constraint(equalToConstant: 56),

            logoutButton.widthAnchor.constraint(equalToConstant: 128)
        )
    }
}
