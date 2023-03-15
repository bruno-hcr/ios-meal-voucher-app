import UIKit
import MealVoucherDetailInterface
import RouterServiceInterface

public final class MealVoucherDetailRouteHandler: RouteHandler {
    public var routes: [Route.Type] = [
        MealVoucherDetailRoute.self
    ]

    public init() {}

    public func destination(
        forRoute route: Route,
        fromViewController viewController: UIViewController
    ) -> Feature.Type {
        guard route is MealVoucherDetailRoute else {
            preconditionFailure()
        }

        return MealVoucherDetailFeature.self
    }
}
