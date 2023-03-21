import Components
import CommonAssets
import ImageFetcherInterface
import MealVoucherDetailInterface
import UIKit

protocol MealVoucherDetailViewProtocol {
    func display(viewModel: MealVoucherDetailView.ViewModel)
}

protocol MealVoucherDetailViewDelegate: AnyObject {
    func didTapOnClose()
}

final class MealVoucherDetailView: UIView, MealVoucherDetailViewProtocol {
    struct ViewModel {
        let name: String
        let date: Date
        let amountSymbol: String
        let amountValue: Double
        let smallIcon: Icon
        let largeIcon: Icon

        var formattedAmountCurrencyValue: String {
            "\(amountValue) \(amountSymbol)"
        }

        var formattedDate: String {
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.dateStyle = .long
            return formatter.string(from: date)
        }
    }

    private var viewModel: ViewModel?
    private let imageFetcher: ImageFetcherProtocol
    weak var delegate: MealVoucherDetailViewDelegate?

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.arrow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapOnCloseButton), for: .touchUpInside)
        return button
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 24
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var smallIconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var smallIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var largeIconBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(red: 0.988, green: 0.388, blue: 0.714, alpha: 0.06).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var largeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(red: 0.114, green: 0.067, blue: 0.282, alpha: 1)
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(red: 0.114, green: 0.067, blue: 0.282, alpha: 1)
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(red: 0.569, green: 0.545, blue: 0.651, alpha: 1)
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(imageFetcher: ImageFetcherProtocol) {
        self.imageFetcher = imageFetcher
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func display(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.amountLabel.text = viewModel.formattedAmountCurrencyValue
        self.nameLabel.text = viewModel.name
        self.dateLabel.text = viewModel.formattedDate
        displayImage(with: viewModel.smallIcon, for: smallIconImageView)
        displayImage(with: viewModel.largeIcon, for: largeIconImageView)
    }

    private func displayImage(with icon: Icon, for imageView: UIImageView) {
        if case let .url(urlString) = icon, let url = URL(string: urlString) {
            imageView.fetchImage(with: url, imageFetcher: imageFetcher)
        } else if case let .category(icon) = icon {
            imageView.image = icon.image
            largeIconBackgroundView.backgroundColor = icon.backgroundColor
        }
    }

    @objc private func didTapOnCloseButton() {
        delegate?.didTapOnClose()
    }
}

extension MealVoucherDetailView: ViewCode {
    func setupSubViews() {
        addSubview(scrollView)
        scrollView.addSubview(largeIconBackgroundView)
        scrollView.addSubview(containerStackView)

        largeIconBackgroundView.addSubview(largeIconImageView)
        largeIconBackgroundView.addSubview(smallIconBackgroundView)
        largeIconBackgroundView.addSubview(closeButton)

        smallIconBackgroundView.addSubview(smallIconImageView)

        contentStackView.addArrangedSubview(amountLabel)
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(dateLabel)

        containerStackView.addArrangedSubview(contentStackView)

        ActionMenuItem.allCases.forEach { item in
            actionsStackView.addArrangedSubview(
                ActionItemView(
                    .init(
                        icon: item.icon,
                        description: item.description,
                        actionButtonDescription: item.actionDescription
                    )
                )
            )
        }
        containerStackView.addArrangedSubview(actionsStackView)
    }

    func setupConstraints() {
        setupCloseButtonConstraint()
        setupScrollViewConstraint()
        setupContainerStackViewConstraint()
        setupLargeIconConstraint()
        setupSmallIconImageViewConstraint()
    }

    private func setupCloseButtonConstraint() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: largeIconBackgroundView.topAnchor, constant: 53),
            closeButton.leadingAnchor.constraint(equalTo: largeIconBackgroundView.leadingAnchor, constant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func setupScrollViewConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func setupLargeIconConstraint() {
        NSLayoutConstraint.activate([
            largeIconBackgroundView.heightAnchor.constraint(equalToConstant: 224),
            largeIconBackgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            largeIconBackgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            largeIconBackgroundView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            largeIconBackgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            largeIconImageView.centerYAnchor.constraint(equalTo: largeIconBackgroundView.centerYAnchor),
            largeIconImageView.centerXAnchor.constraint(equalTo: largeIconBackgroundView.centerXAnchor),
            largeIconImageView.heightAnchor.constraint(equalToConstant: 57),
            largeIconImageView.widthAnchor.constraint(equalToConstant: 57)

        ])
    }

    private func setupContainerStackViewConstraint() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: largeIconBackgroundView.bottomAnchor, constant: 24),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20)
        ])
    }

    private func setupSmallIconImageViewConstraint() {
        NSLayoutConstraint.activate([
            smallIconBackgroundView.bottomAnchor.constraint(equalTo: largeIconBackgroundView.bottomAnchor, constant: 10),
            smallIconBackgroundView.trailingAnchor.constraint(equalTo: largeIconBackgroundView.trailingAnchor, constant: -32),
            smallIconBackgroundView.heightAnchor.constraint(equalToConstant: 32),
            smallIconBackgroundView.widthAnchor.constraint(equalToConstant: 32),
            smallIconImageView.topAnchor.constraint(equalTo: smallIconBackgroundView.topAnchor, constant: 6),
            smallIconImageView.bottomAnchor.constraint(equalTo: smallIconBackgroundView.bottomAnchor, constant: -6),
            smallIconImageView.leadingAnchor.constraint(equalTo: smallIconBackgroundView.leadingAnchor, constant: 6),
            smallIconImageView.trailingAnchor.constraint(equalTo: smallIconBackgroundView.trailingAnchor, constant: -6)
        ])
    }

    func setupExtraConfiguration() {
        backgroundColor = .white
    }
}

extension MealVoucherDetailView: ViewAnimatable {
    var targetView: UIView {
        largeIconImageView
    }
}

extension TransactionDetail {
    var viewModel: MealVoucherDetailView.ViewModel {
        .init(
            name: name,
            date: date,
            amountSymbol: amount.symbol,
            amountValue: amount.value,
            smallIcon: smallIcon,
            largeIcon: largeIcon
        )
    }
}
