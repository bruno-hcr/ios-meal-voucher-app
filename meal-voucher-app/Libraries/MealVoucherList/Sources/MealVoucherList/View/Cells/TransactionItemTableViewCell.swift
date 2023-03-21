import Components
import CommonAssets
import ImageFetcherInterface
import MealVoucherListInterface
import UIKit

final class TransactionItemTableViewCell: UITableViewCell {
    struct ViewModel {
        let name: String
        let message: String?
        let amountSymbol: String
        let amountValue: Double
        let smallIcon: Icon
        let largeIcon: Icon

        var formattedAmountCurrencyValue: String {
            "\(amountValue) \(amountSymbol)"
        }
    }

    private var viewModel: ViewModel?
    var imageFetcher: ImageFetcherProtocol?

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            largeIconBackgroundView,
            contentStackView,
            amountLabel
        ])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel

        ])
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var smallIconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
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
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.988, green: 0.388, blue: 0.714, alpha: 0.06).cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var largeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .init(red: 0.114, green: 0.067, blue: 0.282, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .init(red: 0.569, green: 0.545, blue: 0.651, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .init(red: 0.114, green: 0.067, blue: 0.282, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func display(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.name
        self.subtitleLabel.text = viewModel.name
        self.amountLabel.text = viewModel.formattedAmountCurrencyValue
        displayImage(with: viewModel.smallIcon, for: smallIconImageView)
        displayImage(with: viewModel.largeIcon, for: largeIconImageView)
    }

    private func displayImage(with icon: Icon, for imageView: UIImageView) {
        if case let .url(urlString) = icon, let url = URL(string: urlString), let imageFetcher {
            imageView.fetchImage(with: url, imageFetcher: imageFetcher)
        } else if case let .category(icon) = icon {
            imageView.image = icon.image
            largeIconBackgroundView.backgroundColor = icon.backgroundColor
        }
    }
}

extension TransactionItemTableViewCell: ViewCode {
    func setupSubViews() {
        addSubview(containerStackView)
        largeIconBackgroundView.addSubview(largeIconImageView)
        addSubview(smallIconBackgroundView)
        smallIconBackgroundView.addSubview(smallIconImageView)
    }

    func setupConstraints() {
        setupContainerStackViewConstraint()
        setupLargeIconImageViewConstraint()
        setupSmallIconImageViewConstraint()
    }

    private func setupContainerStackViewConstraint() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    private func setupLargeIconImageViewConstraint() {
        NSLayoutConstraint.activate([
            largeIconBackgroundView.heightAnchor.constraint(equalToConstant: 56),
            largeIconBackgroundView.widthAnchor.constraint(equalToConstant: 56),
            largeIconImageView.topAnchor.constraint(equalTo: largeIconBackgroundView.topAnchor, constant: 14),
            largeIconImageView.bottomAnchor.constraint(equalTo: largeIconBackgroundView.bottomAnchor, constant: -14),
            largeIconImageView.leadingAnchor.constraint(equalTo: largeIconBackgroundView.leadingAnchor, constant: 14),
            largeIconImageView.trailingAnchor.constraint(equalTo: largeIconBackgroundView.trailingAnchor, constant: -14)
        ])
    }

    private func setupSmallIconImageViewConstraint() {
        NSLayoutConstraint.activate([
            smallIconBackgroundView.bottomAnchor.constraint(equalTo: largeIconBackgroundView.bottomAnchor, constant: 4),
            smallIconBackgroundView.trailingAnchor.constraint(equalTo: largeIconBackgroundView.trailingAnchor, constant: 4),
            smallIconBackgroundView.heightAnchor.constraint(equalToConstant: 24),
            smallIconBackgroundView.widthAnchor.constraint(equalToConstant: 24),
            smallIconImageView.topAnchor.constraint(equalTo: smallIconBackgroundView.topAnchor, constant: 6),
            smallIconImageView.bottomAnchor.constraint(equalTo: smallIconBackgroundView.bottomAnchor, constant: -6),
            smallIconImageView.leadingAnchor.constraint(equalTo: smallIconBackgroundView.leadingAnchor, constant: 6),
            smallIconImageView.trailingAnchor.constraint(equalTo: smallIconBackgroundView.trailingAnchor, constant: -6)
        ])
    }
}

extension Transaction {
    var viewModel: MealVoucherListView.ViewModel {
        .init(
            name: name,
            message: message,
            amountSymbol: amount.symbol,
            amountValue: amount.value,
            smallIcon: smallIcon,
            largeIcon: largeIcon
        )
    }
}
