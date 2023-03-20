import UIKit
import MealVoucherListInterface

final class MealVoucherDetailViewController: UIViewController {
    private let customView: MealVoucherDetailViewProtocol & UIView
    private let service: TransactionDetailServiceProtocol

    init(
        customView: MealVoucherDetailViewProtocol & UIView,
        service: TransactionDetailServiceProtocol
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
        getTransactionDetail()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func getTransactionDetail() {
        service.getTransactionDetail { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let transactionDetail):
                self.customView.display(viewModel: transactionDetail.viewModel)
            case .failure:
                break
            }
        }
    }
}
