import Combine
import UIKit

struct BottomSheetAction {
    var title: String?
    var style: ButtonStyle
    var handler: VoidBlock
}

extension BottomSheetAction {

    enum ButtonStyle: CaseIterable {
        case `default`
        case cancel
        case alert

        var type: ViewStyle<UIButton> {
            switch self {
                case .default:
                    return .bottomSheetDefaultStyle

                case .cancel:
                    return .bottomSheetCanceltStyle

                case .alert:
                    return .bottomSheetAlertStyle
            }
        }

        var value: String {
            switch self {
                case .default:
                    return "DEFAULT"

                case .cancel:
                    return "CANCEL"

                case .alert:
                    return "ALERT"
            }
        }
    }
}

// MARK: - stored properties & init

final class CommonBottomSheetContentView: UIView {

    private lazy var baseStackView: UIStackView = .init(
        subViews: [titleLabelBackView, messageBodyLabel, buttonContainerStackView],
        style: .vertical,
        distributon: .equalSpacing,
        space: 16
    )

    private let titleLabelBackView = UIView()

    private let titleLabel: UILabel = .init(
        styles: [.numberOfLinesZero, .centerAlignment],
        fontType: .bold,
        fontSize: .h1
    )

    private let messageBodyLabel: UILabel = .init(
        styles: [.numberOfLinesZero, .centerAlignment],
        fontType: .italic,
        fontSize: .h2
    )

    private lazy var buttonContainerStackView: UIStackView = .init(
        subViews: [],
        style: .vertical,
        space: 16
    )

    private var cancellables: Set<AnyCancellable> = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - internal methods

extension CommonBottomSheetContentView {

    func set(
        title: String?,
        body: String?,
        actions: [BottomSheetAction]
    ) {
        configureTitleLabel(title: title)
        configureMessageBodyLabel(body: body)
        configureButtons(actions)
    }
}

// MARK: - private methods

private extension CommonBottomSheetContentView {

    func setupView() {
        backgroundColor = .systemBackground

        addSubViews(
            baseStackView,
            titleLabel,

            constraints:
            baseStackView.topAnchor.constraint(equalTo: topAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            baseStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),

            titleLabel.topAnchor.constraint(equalTo: titleLabelBackView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleLabelBackView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: titleLabelBackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleLabelBackView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        )
    }

    func configureTitleLabel(title: String?) {
        if let title = title {
            titleLabel.text = title
            titleLabelBackView.isHidden = false
        } else {
            titleLabelBackView.isHidden = true
        }
    }

    func configureMessageBodyLabel(body: String?) {
        if let body = body {
            messageBodyLabel.text = body
            messageBodyLabel.isHidden = false
        } else {
            messageBodyLabel.isHidden = true
        }
    }

    func configureButtons(_ actions: [BottomSheetAction]) {
        actions.map { makeButton(by: $0) }.forEach {
            self.buttonContainerStackView.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalToConstant: 52).isActive = true
        }
    }

    func makeButton(by action: BottomSheetAction) -> UIButton {
        let button = UIButton(style: action.style.type)
        button.setTitle(action.title, for: .normal)
        button.publisher(for: .touchUpInside).sink { _ in
            action.handler()
        }
        .store(in: &cancellables)

        return button
    }
}
