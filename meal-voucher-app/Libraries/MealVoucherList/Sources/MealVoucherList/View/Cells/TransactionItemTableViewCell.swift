import Components
import ImageFetcherInterface
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
            largeIconView,
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
    
    private lazy var smallIconView: UIView = {
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
        imageView.tintColor = UIColor(red: 0.992, green: 0.609, blue: 0.157, alpha: 1)
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var largeIconView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.988, green: 0.388, blue: 0.714, alpha: 0.06).cgColor
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var largeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.992, green: 0.609, blue: 0.157, alpha: 1)
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
//        if case let .url(urlString) = icon, let url = URL(string: urlString) {
//            imageView.fetchImage(with: url, imageFetcher: <#T##ImageFetcher#>)
//        } else
        if case let .category(icon) = icon {
            imageView.image = icon.image
            largeIconView.backgroundColor = icon.backgroundColor
        }
    }
}

extension TransactionItemTableViewCell: ViewCode {
    func setupSubViews() {
        addSubview(containerStackView)
        largeIconView.addSubview(largeIconImageView)
        addSubview(smallIconView)
        smallIconView.addSubview(smallIconImageView)
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
            largeIconView.heightAnchor.constraint(equalToConstant: 56),
            largeIconView.widthAnchor.constraint(equalToConstant: 56),
            largeIconImageView.topAnchor.constraint(equalTo: largeIconView.topAnchor, constant: 14),
            largeIconImageView.bottomAnchor.constraint(equalTo: largeIconView.bottomAnchor, constant: -14),
            largeIconImageView.leadingAnchor.constraint(equalTo: largeIconView.leadingAnchor, constant: 14),
            largeIconImageView.trailingAnchor.constraint(equalTo: largeIconView.trailingAnchor, constant: -14)
        ])
    }

    private func setupSmallIconImageViewConstraint() {
        NSLayoutConstraint.activate([
            smallIconView.bottomAnchor.constraint(equalTo: largeIconView.bottomAnchor, constant: 4),
            smallIconView.trailingAnchor.constraint(equalTo: largeIconView.trailingAnchor, constant: 4),
            smallIconView.heightAnchor.constraint(equalToConstant: 24),
            smallIconView.widthAnchor.constraint(equalToConstant: 24),
            smallIconImageView.topAnchor.constraint(equalTo: smallIconView.topAnchor, constant: 6),
            smallIconImageView.bottomAnchor.constraint(equalTo: smallIconView.bottomAnchor, constant: -6),
            smallIconImageView.leadingAnchor.constraint(equalTo: smallIconView.leadingAnchor, constant: 6),
            smallIconImageView.trailingAnchor.constraint(equalTo: smallIconView.trailingAnchor, constant: -6)
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
