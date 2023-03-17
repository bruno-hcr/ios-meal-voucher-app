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
        service.getTransaction { result in
            switch result {
            case .success:
                print("foo")
            case .failure:
                print("bar")
            }
        }
    }
}
