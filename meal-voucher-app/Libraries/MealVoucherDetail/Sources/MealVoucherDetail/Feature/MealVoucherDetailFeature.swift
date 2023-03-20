import UIKit
import ImageFetcherInterface
import MealVoucherDetailInterface
import RouterServiceInterface

struct MealVoucherDetailFeature: Feature {
    @Dependency var imageFetcher: ImageFetcherProtocol

    func build(fromRoute route: Route?) -> UIViewController {
        guard let route = route as? MealVoucherDetailRoute else {
            preconditionFailure()
        }

        let view = MealVoucherDetailView(imageFetcher: imageFetcher)
        let service = TransactionDetailService(transactionDetail: route.transactionDetail)

        let viewController = MealVoucherDetailViewController(
            customView: view,
            service: service
        )
        view.delegate = viewController
        return viewController
    }
}
