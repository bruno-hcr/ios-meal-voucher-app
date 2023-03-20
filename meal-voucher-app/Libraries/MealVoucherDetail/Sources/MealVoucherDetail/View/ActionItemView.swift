import CommonAssets
import Components
import UIKit

final class ActionItemView: UIView {
    struct ViewModel {
        let icon: IconImage
        let description: String
        let actionButtonDescription: String?

        var actionButtonIsHidden: Bool {
            actionButtonDescription == nil
        }
    }

    private let viewModel: ViewModel

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(red: 0.933, green: 0.929, blue: 0.945, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var iconBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.988, green: 0.388, blue: 0.714, alpha: 0.06).cgColor
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.backgroundColor = viewModel.icon.backgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = viewModel.icon.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(red: 0.114, green: 0.067, blue: 0.282, alpha: 1)
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = viewModel.description
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textColor = .init(red: 0.388, green: 0.247, blue: 0.827, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.backgroundColor = .clear
        button.setTitle(viewModel.actionButtonDescription, for: .normal)
        button.isHidden = viewModel.actionButtonIsHidden
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActionItemView: ViewCode {
    func setupSubViews() {
        stackView.addArrangedSubview(iconBackgroundView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(actionButton)
        addSubview(stackView)
        iconBackgroundView.addSubview(iconImageView)
        addSubview(separatorView)
    }

    func setupConstraints() {
        setupStackViewConstraint()
        setupIconViewConstraint()
        setupActionButtonConstraint()
        setupSeparatorViewConstraint()
    }

    func setupExtraConfiguration() {
        backgroundColor = .white
    }

    private func setupStackViewConstraint() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupIconViewConstraint() {
        NSLayoutConstraint.activate([
            iconBackgroundView.heightAnchor.constraint(equalToConstant: 32),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: 32),
            iconImageView.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 15),
            iconImageView.widthAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupSeparatorViewConstraint() {
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            separatorView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupActionButtonConstraint() {
        NSLayoutConstraint.activate([
            actionButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}

enum ActionMenuItem: CaseIterable {
    case mealVouchers
    case share
    case favorite
    case report

    var icon: IconImage {
        return .mealVoucher
    }

    var description: String {
        switch self {
        case .mealVouchers:
            return "Meal Vouchers"
        case .share:
            return "Share Bill"
        case .favorite:
            return "Favorite"
        case .report:
            return "Report a Problem"
        }
    }

    var actionDescription: String? {
        switch self {
        case .mealVouchers:
            return "Change Account"
        default:
            return nil
        }
    }
}
