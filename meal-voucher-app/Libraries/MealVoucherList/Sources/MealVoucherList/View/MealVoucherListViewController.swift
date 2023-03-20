import UIKit
import MealVoucherDetailInterface
import MealVoucherListInterface
import RouterServiceInterface

final class MealVoucherListViewController: UIViewController {
    private let customView: MealVoucherListViewProtocol & UIView
    private let service: TransactionListServiceProtocol
    private let routerService: RouterServiceProtocol

    private var transactions: [Transaction] = []

    init(
        customView: MealVoucherListViewProtocol & UIView,
        service: TransactionListServiceProtocol,
        routerService: RouterServiceProtocol
    ) {
        self.customView = customView
        self.service = service
        self.routerService = routerService
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
        navigationItem.title = "Meal Vouchers"
        getTransactionList()
    }

    private func getTransactionList() {
        service.getTransactionList { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let transactionList):
                self.transactions = transactionList
                self.customView.display(viewModel: transactionList.map(\.viewModel))
            case .failure:
                self.transactions = []
                break
            }
        }
    }

    private func navigateToTransactionDetail(with transaction: Transaction) {
        let route = MealVoucherDetailRoute(transactionDetail: .map(from: transaction))

        routerService.navigate(
            toRoute: route,
            fromView: self,
            presentationStyle: Push(),
            animated: true
        )
    }
}

extension MealVoucherListViewController: MealVoucherListViewDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        let selectedTransaction = transactions[indexPath.row]
        navigateToTransactionDetail(with: selectedTransaction)
    }
}
