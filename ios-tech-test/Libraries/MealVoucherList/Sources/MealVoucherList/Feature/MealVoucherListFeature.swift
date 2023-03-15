import UIKit
import MealVoucherListInterface
import RouterServiceInterface
import NetworkInterface

struct MealVoucherListFeature: Feature {
    @Dependency var network: HTTPClientProtocol
    @Dependency var routerService: RouterServiceProtocol

    func build(fromRoute route: Route?) -> UIViewController {
        let service = TransactionService(network: network)
        let view = MealVoucherListView()
        let viewController = MealVoucherListViewController(
            customView: view
        )

        return viewController
    }
}
