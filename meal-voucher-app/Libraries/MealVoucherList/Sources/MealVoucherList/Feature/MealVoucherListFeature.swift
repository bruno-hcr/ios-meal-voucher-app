import UIKit
import ImageFetcherInterface
import MealVoucherListInterface
import RouterServiceInterface
import NetworkInterface

struct MealVoucherListFeature: Feature {
    @Dependency var network: HTTPClientProtocol
    @Dependency var routerService: RouterServiceProtocol
    @Dependency var imageFetcher: ImageFetcherProtocol

    func build(fromRoute route: Route?) -> UIViewController {
        let service = TransactionListService(network: network)
        let view = MealVoucherListView(imageFetcher: imageFetcher)
        let viewController = MealVoucherListViewController(
            customView: view,
            service: service,
            routerService: routerService
        )
        view.delegate = viewController
        return viewController
    }
}
