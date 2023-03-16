import UIKit

final class MealVoucherListViewController: UIViewController {
    private let customView: MealVoucherListViewProtocol & UIView
    private let service: TransactionListServiceProtocol

    init(
        customView: MealVoucherListViewProtocol & UIView,
        service: TransactionListServiceProtocol
    ) {
        self.customView = customView
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Transaction List"
        getTransactionList()
    }

    private func getTransactionList() {
        service.getTransactionList { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let transactionList):
                self.customView.display(viewModel: transactionList.map(\.viewModel))
            case .failure:
                break
            }
        }
    }
}

extension MealVoucherListViewController: MealVoucherListViewDelegate {
    func didSelectTransaction() {

    }
}
