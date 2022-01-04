import UIKit

// MARK: - stored properties & init

final class HomeHeader: UICollectionReusableView {

    private let headerLabel: UILabel = .init(
        styles: [.leftAlignment],
        fontType: .bold,
        fontSize: .h1
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

extension HomeHeader {

    func configure(title: String) {
        headerLabel.text = title
    }
}

// MARK: - private methods

private extension HomeHeader {

    func setupView() {
        addSubViews(
            headerLabel,

            constraints:
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        )
    }
}
