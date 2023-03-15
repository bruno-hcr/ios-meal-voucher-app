import UIKit
import MealVoucherDetailInterface
import RouterServiceInterface

struct MealVoucherDetailFeature: Feature {
    func build(fromRoute route: Route?) -> UIViewController {
        guard route is MealVoucherDetailRoute else {
            preconditionFailure()
        }

        let view = MealVoucherDetailView()
        let viewController = MealVoucherDetailViewController(
            customView: view
        )

        return viewController
    }
}
