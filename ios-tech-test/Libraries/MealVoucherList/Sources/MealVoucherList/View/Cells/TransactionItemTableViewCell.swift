import Components
import Kingfisher
import MealVoucherListInterface
import UIKit

final class TransactionItemTableViewCell: UITableViewCell {
    struct ViewModel {
        let transactionName: String
        let transactionMessage: String?
        let transactionDate: Date
        let transactionAmountSymbol: String
        let transactionAmountValue: Double
        let smallIcon: Transaction.Icon
        let largeIcon: Transaction.Icon

        var amountFormatted: String {
            "\(transactionAmountValue) \(transactionAmountSymbol)"
        }
    }

    private var viewModel: ViewModel?

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            largeIconImageView,
            contentStackView,
            amountLabel
        ])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
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

    private lazy var smallIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.992, green: 0.609, blue: 0.157, alpha: 1)
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 1
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var largeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.992, green: 0.609, blue: 0.157, alpha: 1)
        imageView.layer.cornerRadius = 1
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(red: 1, green: 0.922, blue: 0.831, alpha: 1).cgColor
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
        self.titleLabel.text = viewModel.transactionName
        self.subtitleLabel.text = viewModel.transactionName
        self.amountLabel.text = viewModel.amountFormatted
        displayImage(with: viewModel.smallIcon, for: smallIconImageView)
        displayImage(with: viewModel.largeIcon, for: largeIconImageView)
    }

    private func displayImage(with icon: Transaction.Icon, for imageView: UIImageView) {
        if case let .url(urlString) = icon, let url = URL(string: urlString) {
            imageView.kf.setImage(with: url)
        } else if case let .category(icon) = icon {
            imageView.image = icon.toUIImage()
        }
    }
}

extension TransactionItemTableViewCell: ViewCode {
    func setupSubViews() {
        addSubview(containerStackView)
        addSubview(smallIconImageView)
    }

    func setupConstraints() {
        setupContainerStackViewConstraint()
        setupLargeIconImageViewConstraint()
        setupSmallIconImageViewConstraint()
    }

    private func setupContainerStackViewConstraint() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    private func setupLargeIconImageViewConstraint() {
        NSLayoutConstraint.activate([
            largeIconImageView.heightAnchor.constraint(equalToConstant: 56),
            largeIconImageView.widthAnchor.constraint(equalToConstant: 56)
        ])
    }

    private func setupSmallIconImageViewConstraint() {
        NSLayoutConstraint.activate([
            smallIconImageView.bottomAnchor.constraint(equalTo: largeIconImageView.bottomAnchor),
            smallIconImageView.trailingAnchor.constraint(equalTo: largeIconImageView.trailingAnchor),
            smallIconImageView.heightAnchor.constraint(equalToConstant: 12),
            smallIconImageView.widthAnchor.constraint(equalToConstant: 12)
        ])
    }
}

extension Transaction {
    var viewModel: MealVoucherListView.ViewModel {
        .init(
            transactionName: name,
            transactionMessage: message,
            transactionDate: date,
            transactionAmountSymbol: amount.symbol,
            transactionAmountValue: amount.value,
            smallIcon: smallIcon,
            largeIcon: largeIcon
        )
    }
}
