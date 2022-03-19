#if DEBUG

import Combine
import UIKit

// MARK: - stored properties & init

final class ProfileCell: UITableViewCell {
    private let titleLabel: UILabel = .init(
        style: .profileTitle
    )

    private let nameTextField: BottomBorderTextField = .init(
        style: .debug
    )

    private let saveButton: AnimationButton = .init(
        style: .profileNameSave
    )

    lazy var nameTextPublisher: AnyPublisher<String, Never> = {
        nameTextField.textDidChangePublisher
    }()

    lazy var buttonTapPublisher: UIControl.Publisher<AnimationButton> = {
        saveButton.publisher(for: .touchUpInside)
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        saveButton.layer.borderColor = Resources.Colors.dynamicColor.cgColor
    }
}

// MARK: - internal methods

extension ProfileCell {

    func configure(title: String) {
        titleLabel.text = title.addSpaceAfterUppercase().uppercased()
    }
}

// MARK: - private methods

private extension ProfileCell {

    func setupView() {
        contentView.addSubViews(
            titleLabel,
            nameTextField,
            saveButton,

            constraints:
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),

            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            nameTextField.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -8),
            nameTextField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),

            saveButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            saveButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 80)
        )
    }
}

#endif
