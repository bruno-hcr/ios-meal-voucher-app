import Components
import UIKit

protocol MealVoucherListViewDelegate: AnyObject {
    func didSelectTransaction()
}

protocol MealVoucherListViewProtocol {
    func display(viewModel: [MealVoucherListView.ViewModel])
}

final class MealVoucherListView: UIView, MealVoucherListViewProtocol {
    typealias ViewModel = TransactionItemTableViewCell.ViewModel

    private var viewModel: [ViewModel] = []
    weak var delegate: MealVoucherListViewDelegate?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(cellClass: TransactionItemTableViewCell.self)
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func display(viewModel: [ViewModel]) {
        self.viewModel = viewModel
        reloadTableView()
    }

    private func reloadTableView() {
        tableView.reloadData()
    }
}

extension MealVoucherListView: ViewCode {
    func setupSubViews() {
        addSubview(tableView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

extension MealVoucherListView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellClass: TransactionItemTableViewCell.self, forIndexPath: indexPath)
        let item = viewModel[indexPath.row]
        cell.display(item)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel[indexPath.row]
        delegate?.didSelectTransaction()
    }
}