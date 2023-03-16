import UIKit
import MealVoucherListInterface
import RouterServiceInterface
import NetworkInterface

struct MealVoucherListFeature: Feature {
    @Dependency var network: HTTPClientProtocol
    @Dependency var routerService: RouterServiceProtocol

    func build(fromRoute route: Route?) -> UIViewController {
        let service = TransactionListService(network: network)
        let view = MealVoucherListView()
        let viewController = MealVoucherListViewController(
            customView: view,
            service: service
        )
        view.delegate = viewController
        return viewController
    }
}
