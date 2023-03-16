import UIKit
import MealVoucherDetailInterface
import RouterServiceInterface

struct MealVoucherDetailFeature: Feature {
    func build(fromRoute route: Route?) -> UIViewController {
        guard let route = route as? MealVoucherDetailRoute else {
            preconditionFailure()
        }

        let view = MealVoucherDetailView()
        let service = TransactionDetailService(transaction: route.transaction)

        let viewController = MealVoucherDetailViewController(
            customView: view,
            service: service
        )

        return viewController
    }
}
